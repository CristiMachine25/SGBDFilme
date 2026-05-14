-- =====================================================================
-- 05_populate.sql
-- Populare cu date realiste pentru proiectul PSGBD - Platforma Filme
-- Minim 15 inregistrari per tabela
-- =====================================================================

SET DEFINE OFF;

-- =====================================================================
-- CATEGORII (16 randuri)
-- =====================================================================
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Actiune');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Comedie');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Drama');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Horror');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'SF');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Thriller');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Romantic');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Animatie');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Aventura');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Documentar');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Musical');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Mister');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Crima');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Familie');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Fantasy');
INSERT INTO categorii (id, nume) VALUES (seq_categorii.NEXTVAL, 'Razboi');

-- Categorii IDs (presupunem 1..16): 1=Actiune, 2=Comedie, 3=Drama, 4=Horror,
-- 5=SF, 6=Thriller, 7=Romantic, 8=Animatie, 9=Aventura, 10=Documentar,
-- 11=Musical, 12=Mister, 13=Crima, 14=Familie, 15=Fantasy, 16=Razboi

-- =====================================================================
-- FILME (18 randuri)
-- =====================================================================
INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Inception', 'Un hot specializat in extragerea secretelor din subconstient primeste o sarcina inversa: implantarea unei idei in mintea unui CEO.', 2010, 5);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'The Shawshank Redemption', 'Doi detinuti dezvolta o prietenie remarcabila intr-o inchisoare din Maine, gasind alinare si rascumparare prin acte de decenta comuna.', 1994, 3);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'The Dark Knight', 'Batman se confrunta cu Joker, un criminal psihopat care arunca Gotham City in haos si testeaza limitele morale ale eroului.', 2008, 1);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Forrest Gump', 'Povestea vietii unui barbat simplu din Alabama care traverseaza decenii de istorie americana, iubind-o constant pe Jenny.', 1994, 3);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Pulp Fiction', 'Vietile a doi asasini mafioti, a unui boxer si a unei perechi de jefuitori se intrepatrund in patru povesti de violenta si rascumparare.', 1994, 13);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'The Matrix', 'Un programator descopera ca realitatea pe care o cunoaste este o simulare creata de masini si se alatura unei rezistente.', 1999, 5);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Interstellar', 'O echipa de exploratori calatoreste printr-o gaura de vierme in spatiu pentru a asigura supravietuirea umanitatii pe o noua planeta.', 2014, 5);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Gladiator', 'Un general roman tradat, devenit sclav si gladiator, cauta razbunarea impotriva imparatului corupt care i-a ucis familia.', 2000, 1);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Titanic', 'O poveste de dragoste tragica intre Jack si Rose pe transatlanticul nescufundabil Titanic in calatoria sa de neuitat.', 1997, 7);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'The Godfather', 'Patriarhul unei dinastii a crimei organizate transfera controlul imperiului sau clandestin fiului sau reticent.', 1972, 13);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Schindlers List', 'In Polonia ocupata, industriasul Oskar Schindler devine ingrijorat de muncitorii sai evrei si incearca sa-i salveze de Holocaust.', 1993, 16);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Goodfellas', 'Povestea ascensiunii si caderii lui Henry Hill, un tanar care viseaza sa devina gangster intr-o familie mafiota din New York.', 1990, 13);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'The Lord of the Rings', 'Un hobbit si o companie eterogena pornesc intr-o calatorie epica pentru a distruge inelul puterii in Muntele Osandei.', 2001, 15);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Fight Club', 'Un angajat insomniac si un producator sapunier formeaza un club de lupta subteran care evolueaza in ceva mult mai sinistru.', 1999, 3);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Avatar', 'Un marine paraplegic trimis pe luna Pandora descopera o lume vibranta si se indragosteste de un membru al tribului Navi.', 2009, 5);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Joker', 'Un comediant ratat din Gotham City coboara intr-o spirala de nebunie si devine simbolul revoltei impotriva societatii.', 2019, 3);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'Parasite', 'O familie saraca se infiltreaza incet in viata unei familii bogate, dezvaluind un secret sumbru ascuns sub vila moderna.', 2019, 6);

INSERT INTO filme (id, titlu, descriere, an_lansare, categorie_id)
VALUES (seq_filme.NEXTVAL, 'La La Land', 'O actrita aspiranta si un pianist de jazz se indragostesc in Los Angeles in timp ce isi urmaresc visele artistice.', 2016, 11);

-- Filme IDs (presupunem 1..18): 1=Inception, 2=Shawshank, 3=DarkKnight,
-- 4=ForrestGump, 5=PulpFiction, 6=Matrix, 7=Interstellar, 8=Gladiator,
-- 9=Titanic, 10=Godfather, 11=Schindler, 12=Goodfellas, 13=LOTR,
-- 14=FightClub, 15=Avatar, 16=Joker, 17=Parasite, 18=LaLaLand

-- =====================================================================
-- ACTORI (20 randuri)
-- =====================================================================
INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Leonardo DiCaprio', 'Leonardo', 'DiCaprio', TO_DATE('1974-11-11', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Christian Bale', 'Christian', 'Bale', TO_DATE('1974-01-30', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Brad Pitt', 'Brad', 'Pitt', TO_DATE('1963-12-18', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Morgan Freeman', 'Morgan', 'Freeman', TO_DATE('1937-06-01', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Tom Hanks', 'Tom', 'Hanks', TO_DATE('1956-07-09', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Robert De Niro', 'Robert', 'De Niro', TO_DATE('1943-08-17', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Al Pacino', 'Alfredo', 'Pacino', TO_DATE('1940-04-25', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Denzel Washington', 'Denzel', 'Washington', TO_DATE('1954-12-28', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Joaquin Phoenix', 'Joaquin', 'Phoenix', TO_DATE('1974-10-28', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Anne Hathaway', 'Anne', 'Hathaway', TO_DATE('1982-11-12', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Scarlett Johansson', 'Scarlett', 'Johansson', TO_DATE('1984-11-22', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Natalie Portman', 'Natalie', 'Portman', TO_DATE('1981-06-09', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Meryl Streep', 'Mary Louise', 'Streep', TO_DATE('1949-06-22', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Cate Blanchett', 'Catherine', 'Blanchett', TO_DATE('1969-05-14', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Heath Ledger', 'Heath', 'Ledger', TO_DATE('1979-04-04', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Keanu Reeves', 'Keanu', 'Reeves', TO_DATE('1964-09-02', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Russell Crowe', 'Russell', 'Crowe', TO_DATE('1964-04-07', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Kate Winslet', 'Kate', 'Winslet', TO_DATE('1975-10-05', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Marlon Brando', 'Marlon', 'Brando', TO_DATE('1924-04-03', 'YYYY-MM-DD'));

INSERT INTO actori (id, nume_scena, prenume, nume_familie, data_nastere)
VALUES (seq_actori.NEXTVAL, 'Hugh Jackman', 'Hugh', 'Jackman', TO_DATE('1968-10-12', 'YYYY-MM-DD'));

-- Actori IDs (1..20): 1=DiCaprio, 2=Bale, 3=Pitt, 4=Freeman, 5=Hanks,
-- 6=DeNiro, 7=Pacino, 8=Washington, 9=Phoenix, 10=Hathaway,
-- 11=Johansson, 12=Portman, 13=Streep, 14=Blanchett, 15=Ledger,
-- 16=Reeves, 17=Crowe, 18=Winslet, 19=Brando, 20=Jackman

-- =====================================================================
-- FILM_ACTORI (25 randuri)
-- =====================================================================
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (1, 1, 'Dom Cobb');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (1, 10, 'Ariadne');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (2, 4, 'Ellis Boyd Redding');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (3, 2, 'Bruce Wayne / Batman');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (3, 15, 'Joker');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (3, 4, 'Lucius Fox');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (4, 5, 'Forrest Gump');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (5, 3, 'Vincent Vega');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (6, 16, 'Neo');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (7, 1, 'Cooper');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (7, 10, 'Amelia Brand');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (8, 17, 'Maximus Decimus Meridius');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (9, 18, 'Rose DeWitt Bukater');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (10, 19, 'Don Vito Corleone');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (10, 7, 'Michael Corleone');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (11, 8, 'Oskar Schindler');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (12, 6, 'Jimmy Conway');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (13, 14, 'Galadriel');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (14, 3, 'Tyler Durden');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (15, 11, 'Neytiri');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (16, 9, 'Arthur Fleck / Joker');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (17, 12, 'Choi Yeon-gyo');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (18, 13, 'Mama lui Mia');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (1, 20, 'Eames');
INSERT INTO film_actori (film_id, actor_id, rol) VALUES (4, 13, 'Doamna Gump');

-- =====================================================================
-- VERSIUNI_FILM (30 randuri)
-- =====================================================================
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 1, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 1, 'MKV', '4K', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 2, 'MP4', '720p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 2, 'WEBM', '1080p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 3, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 3, 'MKV', '4K', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 3, 'AVI', '720p', 'Romana');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 4, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 4, 'WEBM', '720p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 5, 'MKV', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 5, 'MP4', '480p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 6, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 6, 'MKV', '4K', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 7, 'MKV', '4K', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 7, 'MP4', '1080p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 8, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 8, 'AVI', '720p', 'Romana');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 9, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 9, 'MKV', '4K', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 10, 'MKV', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 10, 'MP4', '720p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 11, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 12, 'MKV', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 13, 'MKV', '4K', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 13, 'MP4', '1080p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 14, 'MP4', '1080p', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 15, 'MKV', '4K', 'Engleza');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 16, 'MP4', '1080p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 17, 'MKV', '1080p', 'Subtitrat RO');
INSERT INTO versiuni_film (id, film_id, format, rezolutie, limba) VALUES (seq_versiuni.NEXTVAL, 18, 'MP4', '1080p', 'Engleza');

-- Versiuni IDs: 1..30 (in ordinea inserarii)

-- =====================================================================
-- CLIENTI (16 randuri)
-- =====================================================================
INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Popescu', 'Andrei', 'andrei.popescu@gmail.com', 'Bucuresti', '0721123456');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Ionescu', 'Maria', 'maria.ionescu@yahoo.com', 'Iasi', '0732234567');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Dumitrescu', 'Alexandru', 'alex.dumitrescu@outlook.com', 'Cluj', '0743345678');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Stoica', 'Elena', 'elena.stoica@gmail.com', 'Timisoara', '0754456789');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Constantin', 'Mihai', 'mihai.constantin@gmail.com', 'Brasov', '0765567890');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Marin', 'Ioana', 'ioana.marin@yahoo.com', 'Constanta', '0776678901');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Radu', 'Cristian', 'cristian.radu@gmail.com', 'Sibiu', '0787789012');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Tudor', 'Ana', 'ana.tudor@outlook.com', 'Craiova', '0798890123');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Vasilescu', 'Bogdan', 'bogdan.vasilescu@gmail.com', 'Bucuresti', '0721901234');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Munteanu', 'Diana', 'diana.munteanu@yahoo.com', 'Iasi', '0732012345');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Georgescu', 'Stefan', 'stefan.georgescu@gmail.com', 'Cluj', '0743123450');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Florea', 'Raluca', 'raluca.florea@outlook.com', 'Timisoara', '0754234561');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Pavel', 'Adrian', 'adrian.pavel@gmail.com', 'Brasov', '0765345672');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Nistor', 'Gabriela', 'gabriela.nistor@yahoo.com', 'Constanta', '0776456783');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Sandu', 'Vlad', 'vlad.sandu@gmail.com', 'Sibiu', '0787567894');

INSERT INTO clienti (id, nume, prenume, email, oras, telefon)
VALUES (seq_clienti.NEXTVAL, 'Barbu', 'Camelia', 'camelia.barbu@outlook.com', 'Craiova', '0798678905');

-- Clienti IDs: 1..16

-- =====================================================================
-- VIZUALIZARI (30 randuri)
-- finalizat se seteaza automat de trg_marcheaza_finalizat
-- =====================================================================
INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 1, 1, TO_DATE('2024-09-15', 'YYYY-MM-DD'), 148);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 2, 3, TO_DATE('2024-10-02', 'YYYY-MM-DD'), 142);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 3, 5, TO_DATE('2024-10-20', 'YYYY-MM-DD'), 152);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 4, 8, TO_DATE('2024-11-05', 'YYYY-MM-DD'), 45);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 5, 10, TO_DATE('2024-11-12', 'YYYY-MM-DD'), 154);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 6, 12, TO_DATE('2024-11-18', 'YYYY-MM-DD'), 136);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 7, 14, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 169);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 8, 16, TO_DATE('2024-12-08', 'YYYY-MM-DD'), 155);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 9, 18, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 60);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 10, 20, TO_DATE('2024-12-22', 'YYYY-MM-DD'), 175);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 11, 22, TO_DATE('2025-01-05', 'YYYY-MM-DD'), 195);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 12, 23, TO_DATE('2025-01-12', 'YYYY-MM-DD'), 145);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 13, 24, TO_DATE('2025-01-20', 'YYYY-MM-DD'), 178);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 14, 26, TO_DATE('2025-01-28', 'YYYY-MM-DD'), 30);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 15, 27, TO_DATE('2025-02-05', 'YYYY-MM-DD'), 162);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 16, 28, TO_DATE('2025-02-12', 'YYYY-MM-DD'), 122);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 1, 29, TO_DATE('2025-02-18', 'YYYY-MM-DD'), 132);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 2, 30, TO_DATE('2025-02-25', 'YYYY-MM-DD'), 128);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 3, 2, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 25);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 4, 4, TO_DATE('2025-03-08', 'YYYY-MM-DD'), 140);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 5, 6, TO_DATE('2025-03-14', 'YYYY-MM-DD'), 150);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 6, 7, TO_DATE('2025-03-20', 'YYYY-MM-DD'), 152);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 7, 9, TO_DATE('2025-03-25', 'YYYY-MM-DD'), 70);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 8, 11, TO_DATE('2025-04-01', 'YYYY-MM-DD'), 153);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 9, 13, TO_DATE('2025-04-08', 'YYYY-MM-DD'), 138);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 10, 15, TO_DATE('2025-04-15', 'YYYY-MM-DD'), 165);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 11, 17, TO_DATE('2025-04-22', 'YYYY-MM-DD'), 50);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 12, 19, TO_DATE('2025-04-28', 'YYYY-MM-DD'), 192);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 13, 21, TO_DATE('2025-05-03', 'YYYY-MM-DD'), 158);

INSERT INTO vizualizari (id, client_id, versiune_id, data_vizualizare, durata_minute)
VALUES (seq_vizualizari.NEXTVAL, 14, 25, TO_DATE('2025-05-08', 'YYYY-MM-DD'), 35);

-- =====================================================================
-- VOTURI (30 randuri, comentarii cu cuvinte de sentiment)
-- rating_mediu si nr_voturi se recalculeaza prin trg_recalc_rating
-- =====================================================================
INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 1, 1, 5, 'Excelent film, scenariu impresionant si actori talentati. Recomand cu caldura, este geniu pur!');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 2, 2, 5, 'Minunat si emotionant, un film magistral care te face sa plangi. Captivant de la inceput la sfarsit.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 3, 3, 5, 'Spectaculos si brilliant, Heath Ledger este perfect in rolul Jokerului. Excelent regie si actorie.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 4, 4, 4, 'Foarte placut si emotionant, Tom Hanks este talentat. Un film bun si frumos despre viata.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 5, 5, 4, 'Captivant si bun, dar uneori confuz din cauza structurii non-lineare. In general recomand.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 6, 6, 5, 'Geniu absolut, un film spectaculos care a schimbat genul SF. Excelent si impresionant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 7, 7, 5, 'Impresionant si magistral, Nolan a creat ceva minunat. Scenariu brilliant si efecte spectaculoase.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 8, 8, 4, 'Bun film de actiune, Russell Crowe este talentat. Spectaculos si captivant pe alocuri.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 9, 9, 3, 'Ok, dar lent si exagerat pe alocuri. Frumos vizual dar oarecum banal in poveste.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 10, 10, 5, 'Capodopera, magistral si brilliant. Marlon Brando este perfect, un film impresionant si geniu.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 11, 11, 5, 'Emotionant si impresionant, un film minunat despre umanitate. Recomand, este magistral si brilliant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 12, 12, 5, 'Excelent si captivant, Scorsese la maximum. Actori talentati si scenariu spectaculos.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 13, 13, 5, 'Spectaculos si minunat, fantasy de cel mai inalt nivel. Magistral si impresionant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 14, 14, 2, 'Plictisitor si confuz, m-a dezamagit. Scenariu slab si exagerat, nu mi-a placut.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 15, 15, 4, 'Frumos si spectaculos vizual, dar scenariu banal. Bun in general, recomand pentru efecte.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 16, 16, 5, 'Joaquin Phoenix este geniu, performanta magistrala. Emotionant, captivant si impresionant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 1, 17, 5, 'Brilliant si excelent, un thriller minunat. Scenariu spectaculos si actori talentati.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 2, 18, 5, 'Captivant si emotionant, muzica este perfecta. Frumos si placut, recomand cu caldura.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 3, 1, 4, 'Bun film, complex si impresionant. DiCaprio este talentat dar uneori confuz.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 4, 2, 5, 'Excelent si emotionant, Morgan Freeman este magistral. Recomand, este brilliant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 5, 14, 1, 'Prost, slab si plictisitor. Dezamagit total, scenariu ridicol si banal. Un dezastru.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 6, 16, 2, 'Mediocru si lent, m-a plictisit. Jenant pe alocuri, exagerat si fals.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 7, 9, 2, 'Slab si exagerat, romantism fals. Dezamagit si oarecum jenant in unele scene.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 8, 5, 5, 'Tarantino la cel mai bun nivel, brilliant si excelent. Scenariu impresionant si captivant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 9, 6, 4, 'Bun si captivant, dar uneori confuz cu filosofia sa. Spectaculos vizual.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 10, 7, 5, 'Magistral si impresionant, Nolan este geniu. Emotionant si spectaculos, recomand.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 11, 8, 3, 'Ok, mediu. Nimic special dar nici prost. Frumos vizual dar banal in poveste.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 12, 3, 5, 'Excelent si brilliant, Christian Bale este talentat. Magistral, captivant si impresionant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 13, 10, 5, 'Capodopera absoluta, geniu si magistral. Al Pacino este perfect, scenariu brilliant.');

INSERT INTO voturi (id, client_id, film_id, nota, comentariu)
VALUES (seq_voturi.NEXTVAL, 14, 4, 4, 'Bun si emotionant, placut de privit. Tom Hanks este talentat, recomand.');

-- =====================================================================
-- CUVINTE_SENTIMENT (30 randuri)
-- =====================================================================
-- Polaritate +1 (pozitive)
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'bun', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'excelent', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'frumos', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'placut', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'impresionant', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'talentat', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'captivant', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'recomand', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'minunat', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'perfect', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'geniu', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'brilliant', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'emotionant', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'magistral', 1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'spectaculos', 1);

-- Polaritate -1 (negative)
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'prost', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'slab', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'plictisitor', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'dezamagit', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'oribil', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'jenant', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'mediocru', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'neinteresant', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'lent', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'confuz', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'ridicol', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'dezastru', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'exagerat', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'fals', -1);
INSERT INTO cuvinte_sentiment (id, cuvant, polaritate) VALUES (seq_cuvinte_sentiment.NEXTVAL, 'banal', -1);

COMMIT;
