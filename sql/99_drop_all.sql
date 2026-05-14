-- ============================================================
-- Reset complet schema SGBDFilme. Ruleaza inainte de re-create.
-- ============================================================

BEGIN
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN (
        'VOTURI','VIZUALIZARI','VERSIUNI_FILM','FILM_ACTORI',
        'CUVINTE_SENTIMENT','FILME','ACTORI','CLIENTI','CATEGORII'
    )) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;

    FOR s IN (SELECT sequence_name FROM user_sequences WHERE sequence_name LIKE 'SEQ\_%' ESCAPE '\') LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;

    FOR p IN (SELECT object_name FROM user_objects WHERE object_type = 'PACKAGE' AND object_name = 'PKG_FILME') LOOP
        EXECUTE IMMEDIATE 'DROP PACKAGE ' || p.object_name;
    END LOOP;
END;
/
