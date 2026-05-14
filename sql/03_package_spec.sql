WHENEVER SQLERROR EXIT FAILURE

-- =====================================================================
-- pkg_filme - SPECIFICATIE
-- Pachet PL/SQL pentru platforma de vizionare filme.
-- Contine functii de interogare (detalii filme, actori, versiuni,
-- comentarii, top filme, recomandari, sentiment, predictie sezon)
-- si proceduri pentru inregistrarea vizualizarilor si voturilor.
--
-- Coduri de eroare:
--   -20001 Client inexistent
--   -20002 Versiune inexistenta
--   -20003 Nota invalida
--   -20004 Film inexistent
--   -20005 Luna invalida
--   -20006 Durata invalida
-- =====================================================================

CREATE OR REPLACE PACKAGE pkg_filme AS

    -- 1. Detalii film (titlu, descriere, an, categorie, rating, nr_voturi)
    FUNCTION f_film_detalii(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR;

    -- 2. Actorii unui film (cu rolul)
    FUNCTION f_actori_film(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR;

    -- 3. Versiunile unui film
    FUNCTION f_versiuni_film(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR;

    -- 4. Comentariile/voturile unui film
    FUNCTION f_comentarii_film(p_film_id IN NUMBER)
        RETURN SYS_REFCURSOR;

    -- 5. Top N filme dupa rating si numar de voturi
    FUNCTION f_top_filme(p_limit IN NUMBER DEFAULT 10)
        RETURN SYS_REFCURSOR;

    -- 6. Recomandari pe baza de similaritate intre clienti
    FUNCTION f_recomandari(p_client_id IN NUMBER,
                           p_limit     IN NUMBER DEFAULT 10)
        RETURN SYS_REFCURSOR;

    -- 7. Analiza de sentiment pentru comentariile unui film
    FUNCTION f_sentiment_film(p_film_id IN NUMBER)
        RETURN VARCHAR2;

    -- 8. Predictie sezon: top 5 categorii intr-o luna
    FUNCTION f_predictie_sezon(p_luna IN NUMBER)
        RETURN SYS_REFCURSOR;

    -- 9. Inregistrare vizualizare
    PROCEDURE p_inregistreaza_vizualizare(p_client_id   IN NUMBER,
                                          p_versiune_id IN NUMBER,
                                          p_durata      IN NUMBER);

    -- 10. Vot (insert sau update prin MERGE)
    PROCEDURE p_voteaza(p_client_id  IN NUMBER,
                        p_film_id    IN NUMBER,
                        p_nota       IN NUMBER,
                        p_comentariu IN CLOB DEFAULT NULL);

END pkg_filme;
/
SHOW ERRORS
