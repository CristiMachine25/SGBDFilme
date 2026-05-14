-- ============================================================
-- SGBDFilme - Schema BD (Oracle)
-- Proiect 4 PSGBD: Platforma vizualizare filme
-- Foloseste toate cele 5 tipuri de constrangeri: PK, FK, UNIQUE, NOT NULL, CHECK
-- ============================================================

WHENEVER SQLERROR EXIT FAILURE

-- Tabela 1: categorii de filme
CREATE TABLE categorii (
    id         NUMBER(6)      NOT NULL,
    nume       VARCHAR2(50)   NOT NULL,
    CONSTRAINT pk_categorii PRIMARY KEY (id),
    CONSTRAINT uq_categorii_nume UNIQUE (nume)
);

CREATE SEQUENCE seq_categorii START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 2: filme
CREATE TABLE filme (
    id            NUMBER(8)       NOT NULL,
    titlu         VARCHAR2(200)   NOT NULL,
    descriere     VARCHAR2(2000),
    an_lansare    NUMBER(4)       NOT NULL,
    categorie_id  NUMBER(6)       NOT NULL,
    rating_mediu  NUMBER(3,2)     DEFAULT 0,
    nr_voturi     NUMBER(8)       DEFAULT 0,
    CONSTRAINT pk_filme PRIMARY KEY (id),
    CONSTRAINT fk_filme_categorie FOREIGN KEY (categorie_id) REFERENCES categorii(id),
    CONSTRAINT ck_filme_an CHECK (an_lansare BETWEEN 1900 AND 2100),
    CONSTRAINT ck_filme_rating CHECK (rating_mediu BETWEEN 0 AND 5)
);

CREATE SEQUENCE seq_filme START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 3: actori
CREATE TABLE actori (
    id            NUMBER(8)      NOT NULL,
    nume_scena    VARCHAR2(100)  NOT NULL,
    prenume       VARCHAR2(50)   NOT NULL,
    nume_familie  VARCHAR2(50)   NOT NULL,
    data_nastere  DATE,
    CONSTRAINT pk_actori PRIMARY KEY (id),
    CONSTRAINT uq_actori_nume_scena UNIQUE (nume_scena)
);

CREATE SEQUENCE seq_actori START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 4: asociere film-actor (M:N) cu rol
CREATE TABLE film_actori (
    film_id   NUMBER(8)     NOT NULL,
    actor_id  NUMBER(8)     NOT NULL,
    rol       VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_film_actori PRIMARY KEY (film_id, actor_id),
    CONSTRAINT fk_fa_film  FOREIGN KEY (film_id)  REFERENCES filme(id)  ON DELETE CASCADE,
    CONSTRAINT fk_fa_actor FOREIGN KEY (actor_id) REFERENCES actori(id) ON DELETE CASCADE
);

-- Tabela 5: versiuni film (format, rezolutie, limba)
CREATE TABLE versiuni_film (
    id         NUMBER(8)     NOT NULL,
    film_id    NUMBER(8)     NOT NULL,
    format     VARCHAR2(20)  NOT NULL,
    rezolutie  VARCHAR2(10)  NOT NULL,
    limba      VARCHAR2(30)  NOT NULL,
    CONSTRAINT pk_versiuni PRIMARY KEY (id),
    CONSTRAINT fk_versiuni_film FOREIGN KEY (film_id) REFERENCES filme(id) ON DELETE CASCADE,
    CONSTRAINT uq_versiuni_combo UNIQUE (film_id, format, rezolutie, limba),
    CONSTRAINT ck_versiuni_format CHECK (format IN ('MP4','MKV','WEBM','AVI')),
    CONSTRAINT ck_versiuni_rezolutie CHECK (rezolutie IN ('480p','720p','1080p','4K'))
);

CREATE SEQUENCE seq_versiuni START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 6: clienti
CREATE TABLE clienti (
    id        NUMBER(8)      NOT NULL,
    nume      VARCHAR2(50)   NOT NULL,
    prenume   VARCHAR2(50)   NOT NULL,
    email     VARCHAR2(100)  NOT NULL,
    oras      VARCHAR2(50)   NOT NULL,
    telefon   VARCHAR2(20),
    CONSTRAINT pk_clienti PRIMARY KEY (id),
    CONSTRAINT uq_clienti_email UNIQUE (email),
    CONSTRAINT ck_clienti_email CHECK (email LIKE '%@%.%')
);

CREATE SEQUENCE seq_clienti START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 7: vizualizari
CREATE TABLE vizualizari (
    id                NUMBER(10)  NOT NULL,
    client_id         NUMBER(8)   NOT NULL,
    versiune_id       NUMBER(8)   NOT NULL,
    data_vizualizare  DATE        DEFAULT SYSDATE NOT NULL,
    durata_minute     NUMBER(4)   NOT NULL,
    finalizat         NUMBER(1)   DEFAULT 0 NOT NULL,
    CONSTRAINT pk_vizualizari PRIMARY KEY (id),
    CONSTRAINT fk_viz_client   FOREIGN KEY (client_id)   REFERENCES clienti(id),
    CONSTRAINT fk_viz_versiune FOREIGN KEY (versiune_id) REFERENCES versiuni_film(id),
    CONSTRAINT ck_viz_finalizat CHECK (finalizat IN (0,1)),
    CONSTRAINT ck_viz_durata CHECK (durata_minute >= 0 AND durata_minute <= 600)
);

CREATE SEQUENCE seq_vizualizari START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 8: voturi + comentarii (unul singur per client/film)
CREATE TABLE voturi (
    id          NUMBER(10)  NOT NULL,
    client_id   NUMBER(8)   NOT NULL,
    film_id     NUMBER(8)   NOT NULL,
    nota        NUMBER(1)   NOT NULL,
    comentariu  CLOB,
    data_vot    DATE        DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_voturi PRIMARY KEY (id),
    CONSTRAINT fk_voturi_client FOREIGN KEY (client_id) REFERENCES clienti(id) ON DELETE CASCADE,
    CONSTRAINT fk_voturi_film   FOREIGN KEY (film_id)   REFERENCES filme(id)   ON DELETE CASCADE,
    CONSTRAINT uq_voturi_pereche UNIQUE (client_id, film_id),
    CONSTRAINT ck_voturi_nota CHECK (nota BETWEEN 1 AND 5)
);

CREATE SEQUENCE seq_voturi START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela 9: cuvinte_sentiment - support pentru algoritm analiza sentiment
CREATE TABLE cuvinte_sentiment (
    id          NUMBER(6)     NOT NULL,
    cuvant      VARCHAR2(50)  NOT NULL,
    polaritate  NUMBER(2)     NOT NULL,
    CONSTRAINT pk_cuvinte_sentiment PRIMARY KEY (id),
    CONSTRAINT uq_cuvinte_sentiment UNIQUE (cuvant),
    CONSTRAINT ck_cuvinte_polaritate CHECK (polaritate IN (-1, 1))
);

CREATE SEQUENCE seq_cuvinte_sentiment START WITH 1 INCREMENT BY 1 NOCACHE;

-- Indecsi utili pentru performanta query-urilor
CREATE INDEX idx_voturi_film    ON voturi(film_id);
CREATE INDEX idx_voturi_client  ON voturi(client_id);
CREATE INDEX idx_viz_client     ON vizualizari(client_id);
CREATE INDEX idx_filme_categ    ON filme(categorie_id);

COMMIT;
