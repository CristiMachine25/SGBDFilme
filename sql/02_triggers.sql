WHENEVER SQLERROR EXIT FAILURE

-- =====================================================================
-- 02_triggers.sql
-- Triggers pentru platforma de filme (proiect PSGBD)
--
-- Contine 2 triggere:
--   1) trg_recalc_rating       - compound trigger pe tabela VOTURI.
--      La INSERT / UPDATE / DELETE recalculeaza rating_mediu si nr_voturi
--      pentru fiecare film afectat. Folosim compound trigger pentru a
--      evita problema de mutating table (ORA-04091): colectam id-urile
--      de filme in row events si facem UPDATE-ul in AFTER STATEMENT.
--
--   2) trg_marcheaza_finalizat - BEFORE INSERT FOR EACH ROW pe VIZUALIZARI.
--      Daca durata_minute >= 80, marcheaza vizualizarea ca finalizata
--      (finalizat = 1), altfel finalizat = 0.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1) Recalcul rating mediu si numar voturi pentru filme
-- ---------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_recalc_rating
FOR INSERT OR UPDATE OR DELETE ON voturi
COMPOUND TRIGGER

    -- colectie cu id-urile filmelor afectate
    TYPE t_film_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_filme t_film_ids;

    AFTER EACH ROW IS
    BEGIN
        IF INSERTING OR UPDATING THEN
            v_filme(v_filme.COUNT + 1) := :NEW.film_id;
        END IF;
        IF DELETING OR UPDATING THEN
            v_filme(v_filme.COUNT + 1) := :OLD.film_id;
        END IF;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
        v_avg   NUMBER;
        v_count NUMBER;
    BEGIN
        FOR i IN 1 .. v_filme.COUNT LOOP
            SELECT NVL(AVG(nota), 0), COUNT(*)
              INTO v_avg, v_count
              FROM voturi
             WHERE film_id = v_filme(i);

            UPDATE filme
               SET rating_mediu = v_avg,
                   nr_voturi    = v_count
             WHERE id = v_filme(i);
        END LOOP;
    END AFTER STATEMENT;

END trg_recalc_rating;
/
SHOW ERRORS


-- ---------------------------------------------------------------------
-- 2) Marcheaza automat vizualizarile finalizate (>= 80 minute)
-- ---------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_marcheaza_finalizat
BEFORE INSERT ON vizualizari
FOR EACH ROW
BEGIN
    IF :NEW.durata_minute >= 80 THEN
        :NEW.finalizat := 1;
    ELSE
        :NEW.finalizat := 0;
    END IF;
END trg_marcheaza_finalizat;
/
SHOW ERRORS


-- =====================================================================
-- NOTA: Aceste triggere se compileaza DUPA ce schema (01_schema.sql)
-- a fost creata, pentru ca au nevoie de tabelele filme, voturi si
-- vizualizari sa existe.
-- =====================================================================
