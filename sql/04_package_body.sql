WHENEVER SQLERROR EXIT FAILURE

-- =====================================================================
-- pkg_filme - CORP (BODY)
-- Implementarea pachetului pkg_filme pentru platforma de filme.
-- Functii de interogare, recomandari bazate pe similaritate intre
-- clienti, analiza de sentiment pe comentarii si proceduri pentru
-- inregistrarea vizualizarilor si voturilor.
-- =====================================================================

CREATE OR REPLACE PACKAGE BODY pkg_filme AS

    -- 1. Detalii film -------------------------------------------------
    FUNCTION f_film_detalii(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR
    IS
        v_cur   SYS_REFCURSOR;
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM filme WHERE id = p_film_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Film inexistent');
        END IF;

        OPEN v_cur FOR
            SELECT f.titlu,
                   f.descriere,
                   f.an_lansare,
                   c.nume AS categorie,
                   f.rating_mediu,
                   f.nr_voturi
              FROM filme f
              JOIN categorii c ON c.id = f.categorie_id
             WHERE f.id = p_film_id;

        RETURN v_cur;
    END f_film_detalii;

    -- 2. Actorii unui film --------------------------------------------
    FUNCTION f_actori_film(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR
    IS
        v_cur SYS_REFCURSOR;
    BEGIN
        OPEN v_cur FOR
            SELECT a.nume_scena,
                   a.prenume,
                   a.nume_familie,
                   fa.rol
              FROM film_actori fa
              JOIN actori a ON a.id = fa.actor_id
             WHERE fa.film_id = p_film_id
             ORDER BY a.nume_familie, a.prenume;

        RETURN v_cur;
    END f_actori_film;

    -- 3. Versiunile unui film -----------------------------------------
    FUNCTION f_versiuni_film(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR
    IS
        v_cur SYS_REFCURSOR;
    BEGIN
        OPEN v_cur FOR
            SELECT id, format, rezolutie, limba
              FROM versiuni_film
             WHERE film_id = p_film_id
             ORDER BY id;

        RETURN v_cur;
    END f_versiuni_film;

    -- 4. Comentarii film ----------------------------------------------
    FUNCTION f_comentarii_film(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR
    IS
        v_cur SYS_REFCURSOR;
    BEGIN
        OPEN v_cur FOR
            SELECT cl.nume,
                   cl.prenume,
                   v.nota,
                   v.comentariu,
                   v.data_vot
              FROM voturi v
              JOIN clienti cl ON cl.id = v.client_id
             WHERE v.film_id = p_film_id
             ORDER BY v.data_vot DESC;

        RETURN v_cur;
    END f_comentarii_film;

    -- 5. Top filme ----------------------------------------------------
    FUNCTION f_top_filme(p_limit IN NUMBER DEFAULT 10)
        RETURN SYS_REFCURSOR
    IS
        v_cur SYS_REFCURSOR;
    BEGIN
        OPEN v_cur FOR
            SELECT f.id,
                   f.titlu,
                   f.an_lansare,
                   c.nume AS categorie,
                   f.rating_mediu,
                   f.nr_voturi
              FROM filme f
              JOIN categorii c ON c.id = f.categorie_id
             WHERE f.nr_voturi >= 1
             ORDER BY f.rating_mediu DESC, f.nr_voturi DESC
             FETCH FIRST p_limit ROWS ONLY;

        RETURN v_cur;
    END f_top_filme;

    -- 6. Recomandari bazate pe similaritate ---------------------------
    --    Algoritm:
    --      1) Filmele votate de client cu nota >= 3 (preferinte).
    --      2) Alti clienti care au votat aceleasi filme cu nota in
    --         intervalul +/- 1 fata de nota clientului => calcul
    --         similarity_score = numar filme cu votare similara.
    --      3) Din top 10 clienti similari extragem filmele lor cu
    --         nota >= 4, exceptand filmele deja votate sau vizionate
    --         de clientul curent.
    --      4) Ordonare dupa frecventa (cati clienti similari au
    --         apreciat) si rating_mediu, limitat la p_limit randuri.
    FUNCTION f_recomandari(p_client_id IN NUMBER,
                           p_limit     IN NUMBER DEFAULT 10)
        RETURN SYS_REFCURSOR
    IS
        v_cur   SYS_REFCURSOR;
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM clienti WHERE id = p_client_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Client inexistent');
        END IF;

        OPEN v_cur FOR
            WITH preferinte_client AS (
                -- Pasul 1: filmele preferate de clientul curent
                SELECT film_id, nota
                  FROM voturi
                 WHERE client_id = p_client_id
                   AND nota >= 3
            ),
            clienti_similari AS (
                -- Pasul 2: alti clienti cu gusturi asemanatoare
                SELECT v.client_id,
                       COUNT(*) AS similarity_score
                  FROM voturi v
                  JOIN preferinte_client p ON p.film_id = v.film_id
                 WHERE v.client_id <> p_client_id
                   AND ABS(v.nota - p.nota) <= 1
                 GROUP BY v.client_id
                 ORDER BY similarity_score DESC
                 FETCH FIRST 10 ROWS ONLY
            ),
            filme_vazute AS (
                -- Filme deja vizionate de clientul curent
                SELECT DISTINCT vf.film_id
                  FROM vizualizari viz
                  JOIN versiuni_film vf ON vf.id = viz.versiune_id
                 WHERE viz.client_id = p_client_id
            ),
            filme_votate AS (
                -- Filme deja votate de clientul curent
                SELECT film_id FROM voturi WHERE client_id = p_client_id
            ),
            candidati AS (
                -- Pasul 3: filme apreciate de clientii similari
                SELECT v.film_id,
                       COUNT(*) AS frecventa
                  FROM voturi v
                  JOIN clienti_similari cs ON cs.client_id = v.client_id
                 WHERE v.nota >= 4
                   AND v.film_id NOT IN (SELECT film_id FROM filme_votate)
                   AND v.film_id NOT IN (SELECT film_id FROM filme_vazute)
                 GROUP BY v.film_id
            )
            -- Pasul 4: rezultatul final, ordonat si limitat
            SELECT f.id,
                   f.titlu,
                   f.an_lansare,
                   c.nume AS categorie,
                   f.rating_mediu,
                   cnd.frecventa
              FROM candidati cnd
              JOIN filme f      ON f.id = cnd.film_id
              JOIN categorii c  ON c.id = f.categorie_id
             ORDER BY cnd.frecventa DESC, f.rating_mediu DESC
             FETCH FIRST p_limit ROWS ONLY;

        RETURN v_cur;
    END f_recomandari;

    -- 7. Analiza de sentiment -----------------------------------------
    --    Pentru fiecare comentariu al filmului tokenizam textul in
    --    cuvinte folosind REGEXP_SUBSTR indexat prin CONNECT BY LEVEL.
    --    Cuvintele sunt aduse la litere mici si comparate cu tabela
    --    cuvinte_sentiment. Suma polaritatilor da scorul total.
    FUNCTION f_sentiment_film(p_film_id IN NUMBER)
        RETURN VARCHAR2
    IS
        v_count NUMBER;
        v_total NUMBER := 0;
        v_text  VARCHAR2(4000);
    BEGIN
        SELECT COUNT(*) INTO v_count FROM filme WHERE id = p_film_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Film inexistent');
        END IF;

        -- Parcurgem fiecare comentariu al filmului
        FOR rec IN (SELECT comentariu
                      FROM voturi
                     WHERE film_id = p_film_id
                       AND comentariu IS NOT NULL) LOOP

            -- Convertim CLOB-ul la VARCHAR2 (max 4000 caractere)
            v_text := TO_CHAR(SUBSTR(rec.comentariu, 1, 4000));

            -- Tokenizam textul si insumam polaritatea cuvintelor
            FOR tok IN (
                SELECT LOWER(REGEXP_SUBSTR(v_text,
                                           '[^[:space:][:punct:]]+',
                                           1, LEVEL)) AS cuvant
                  FROM dual
                CONNECT BY REGEXP_SUBSTR(v_text,
                                         '[^[:space:][:punct:]]+',
                                         1, LEVEL) IS NOT NULL
            ) LOOP
                FOR s IN (SELECT polaritate
                            FROM cuvinte_sentiment
                           WHERE cuvant = tok.cuvant) LOOP
                    v_total := v_total + s.polaritate;
                END LOOP;
            END LOOP;
        END LOOP;

        IF v_total > 0 THEN
            RETURN 'pozitiv';
        ELSIF v_total < 0 THEN
            RETURN 'negativ';
        ELSE
            RETURN 'neutru';
        END IF;
    END f_sentiment_film;

    -- 8. Predictie sezon ----------------------------------------------
    FUNCTION f_predictie_sezon(p_luna IN NUMBER)
        RETURN SYS_REFCURSOR
    IS
        v_cur SYS_REFCURSOR;
    BEGIN
        IF p_luna IS NULL OR p_luna < 1 OR p_luna > 12 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Luna invalida');
        END IF;

        OPEN v_cur FOR
            SELECT c.nume AS categorie,
                   COUNT(*) AS nr_vizualizari
              FROM vizualizari viz
              JOIN versiuni_film vf ON vf.id = viz.versiune_id
              JOIN filme f          ON f.id = vf.film_id
              JOIN categorii c      ON c.id = f.categorie_id
             WHERE EXTRACT(MONTH FROM viz.data_vizualizare) = p_luna
             GROUP BY c.nume
             ORDER BY nr_vizualizari DESC
             FETCH FIRST 5 ROWS ONLY;

        RETURN v_cur;
    END f_predictie_sezon;

    -- 9. Inregistreaza vizualizare ------------------------------------
    PROCEDURE p_inregistreaza_vizualizare(p_client_id   IN NUMBER,
                                          p_versiune_id IN NUMBER,
                                          p_durata      IN NUMBER)
    IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM clienti WHERE id = p_client_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Client inexistent');
        END IF;

        SELECT COUNT(*) INTO v_count
          FROM versiuni_film WHERE id = p_versiune_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Versiune inexistenta');
        END IF;

        IF p_durata IS NULL OR p_durata <= 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Durata invalida');
        END IF;

        INSERT INTO vizualizari (id, client_id, versiune_id, durata_minute)
        VALUES (seq_vizualizari.NEXTVAL,
                p_client_id,
                p_versiune_id,
                p_durata);

        COMMIT;
    END p_inregistreaza_vizualizare;

    -- 10. Voteaza (UPSERT prin MERGE) ---------------------------------
    PROCEDURE p_voteaza(p_client_id  IN NUMBER,
                        p_film_id    IN NUMBER,
                        p_nota       IN NUMBER,
                        p_comentariu IN CLOB DEFAULT NULL)
    IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM clienti WHERE id = p_client_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Client inexistent');
        END IF;

        SELECT COUNT(*) INTO v_count FROM filme WHERE id = p_film_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Film inexistent');
        END IF;

        IF p_nota IS NULL OR p_nota < 1 OR p_nota > 5 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Nota invalida');
        END IF;

        MERGE INTO voturi v
        USING (SELECT p_client_id AS client_id,
                      p_film_id   AS film_id
                 FROM dual) src
           ON (v.client_id = src.client_id AND v.film_id = src.film_id)
         WHEN MATCHED THEN
            UPDATE SET v.nota       = p_nota,
                       v.comentariu = p_comentariu,
                       v.data_vot   = SYSDATE
         WHEN NOT MATCHED THEN
            INSERT (id, client_id, film_id, nota, comentariu, data_vot)
            VALUES (seq_voturi.NEXTVAL,
                    p_client_id,
                    p_film_id,
                    p_nota,
                    p_comentariu,
                    SYSDATE);

        COMMIT;
    END p_voteaza;

END pkg_filme;
/
SHOW ERRORS
