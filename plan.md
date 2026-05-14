# Plan implementare SGBDFilme

## Scop

Livrare proiect P4 (Platformă vizualizare filme) care îndeplinește toate cerințele PSGBD: 5+ tabele, 2 triggere, proceduri PL/SQL cu algoritmi non-CRUD, GUI web, prindere excepții, populare automată, totul SIMPLU și funcțional.

## Cerințe de business identificate

1. Un client se autentifică (login simplu cu email - fără parolă, demo).
2. Clientul vede catalog de filme, filtrabile după categorie.
3. Clientul deschide un film și vede: detalii, actori, versiuni disponibile, rating mediu, comentarii.
4. Clientul "vizualizează" un film alegând o versiune (insert în vizualizari).
5. Clientul votează (1-5) un film și lasă comentariu opțional.
6. Clientul primește **recomandări personalizate** pe baza similarității cu alți clienți.
7. Pagina admin: top filme, sentiment per film (din comentarii prin keyword matching), predicții sezoniere.

## Schema BD (BCNF)

9 tabele (depășește minim 5):

1. **categorii** (id, nume UNIQUE)
2. **filme** (id, titlu, descriere, an_lansare, categorie_id FK, rating_mediu calculat, nr_voturi calculat)
3. **actori** (id, nume_scena UNIQUE, prenume, nume_familie, data_nastere)
4. **film_actori** (film_id FK, actor_id FK, rol, PK compus) - asociere M:N
5. **versiuni_film** (id, film_id FK, format, rezolutie, limba, UNIQUE compus)
6. **clienti** (id, nume, prenume, email UNIQUE, oras, telefon)
7. **vizualizari** (id, client_id FK, versiune_id FK, data_vizualizare, durata_minute, finalizat CHECK 0/1)
8. **voturi** (id, client_id FK, film_id FK, nota CHECK 1-5, comentariu CLOB, data_vot, UNIQUE(client_id, film_id))
9. **cuvinte_sentiment** (id, cuvant UNIQUE, polaritate CHECK -1/+1) - support pentru algoritm

## Constrângeri folosite (toate 5 tipuri)

- **PRIMARY KEY** - fiecare tabelă
- **FOREIGN KEY** - 7+ instanțe
- **UNIQUE** - email client, nume scenă actor, (client_id, film_id) vot etc.
- **NOT NULL** - toate câmpurile non-opționale
- **CHECK** - nota IN (1..5), finalizat IN (0,1), polaritate IN (-1,1), an_lansare >= 1900

## Triggere (2)

1. **trg_recalc_rating** - AFTER INSERT OR UPDATE OR DELETE pe `voturi`. Recalculează `filme.rating_mediu` și `filme.nr_voturi`.
2. **trg_marcheaza_finalizat** - BEFORE INSERT pe `vizualizari`. Dacă `durata_minute >= 80` atunci `finalizat := 1`, altfel `0`.

## Pachet PL/SQL `pkg_filme`

### Funcții (callable din Flask)

- `f_film_detalii(p_film_id) RETURN SYS_REFCURSOR`
- `f_top_filme(p_limit) RETURN SYS_REFCURSOR`
- `f_recomandari(p_client_id, p_limit) RETURN SYS_REFCURSOR` - algoritm similaritate
- `f_sentiment_film(p_film_id) RETURN VARCHAR2` - analiză sentiment
- `f_predictie_sezon(p_luna) RETURN SYS_REFCURSOR`

### Proceduri

- `p_inregistreaza_vizualizare(p_client_id, p_versiune_id, p_durata)` - cu excepții
- `p_voteaza(p_client_id, p_film_id, p_nota, p_comentariu)` - cu excepții

### Excepții ridicate (>= 2)

- `-20001 CLIENT_INEXISTENT`
- `-20002 VERSIUNE_INEXISTENTA`
- `-20003 NOTA_INVALIDA`
- `-20004 FILM_INEXISTENT`

Flask prinde minim 2 dintre acestea.

## Algoritm similaritate (recomandări)

Pentru clientul `C`:
1. Găsește alți clienți care au votat **aceleași filme** ca `C` cu nota **±1**.
2. Pentru fiecare astfel de client `O`, scor = numărul de filme cu vot apropiat.
3. Returnează filmele votate cu 4-5 de top-K clienți similari, **excluzând** filmele deja votate/vizualizate de `C`.

## Algoritm sentiment

1. Tabelă `cuvinte_sentiment` cu ~30 cuvinte pozitive/negative.
2. Pentru un film, parcurg comentariile, sparg cu `REGEXP_SUBSTR`, lookup în tabel.
3. Scor = SUM(polaritate). >0 = pozitiv, =0 = neutru, <0 = negativ.

## Frontend Flask - pagini

1. `/` - listă filme + filtru categorie + buton login.
2. `/login` - selectează client din dropdown.
3. `/film/<id>` - detalii film, listă actori, versiuni (cu buton "Vizionează"), comentarii, formular vot.
4. `/recomandari` - apelează `f_recomandari`.
5. `/admin` - top filme, sentiment, predicții.

## Pași de implementare (commit-uri granulare)

### Wave 1 (secvențial)
- **C1:** repo + CLAUDE.md + plan.md + configs
- **C2:** `sql/01_schema.sql`
- **C3:** `sql/99_drop_all.sql`

### Wave 2 (paralel - agenți)
- **Agent A → C4:** `sql/02_triggers.sql`
- **Agent B → C5:** `sql/03_package_spec.sql` + `sql/04_package_body.sql`
- **Agent C → C6:** `sql/05_populate.sql`
- **Agent D → C7+:** Flask app (`app/`)
- **Agent E → C-final:** README.md

## Definition of Done

- [ ] 5+ tabele create
- [ ] 15+ rânduri / tabel
- [ ] 2 triggere
- [ ] Pachet PL/SQL cu min 5 funcții/proceduri
- [ ] Min 4 RAISE_APPLICATION_ERROR
- [ ] Flask prinde minim 2 excepții
- [ ] GUI web cu min 5 pagini
- [ ] README cu pași clari
- [ ] Toate 5 tipuri de constrângeri
- [ ] Algoritm non-CRUD (recomandări + sentiment) în PL/SQL
- [ ] Commit-uri granulare
