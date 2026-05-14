# SGBDFilme - Platformă vizualizare filme (PSGBD Proiect 4)

## Context

Referat-proiect pentru materia "Practică Sisteme de Gestiune Baze de Date" (PSGBD), Facultatea de Informatică Iași. Proiect tip Proiect 4 din lista materiei: platformă de vizualizare filme cu recomandări, voturi, comentarii și analiză sentiment.

Site materie: https://edu.info.uaic.ro/practica-sisteme-gestiune-baze-de-date/ro/index.html

Deadline: 17 mai. Punctaj maxim: 25p.

## Stack tehnic

- **Bază de date:** Oracle (PL/SQL). Compatibil cu Oracle XE 21c / Oracle 19c.
- **Backend:** Python 3.10+ cu Flask.
- **Driver DB:** `oracledb` (nu folosi ORM - este interzis).
- **Frontend:** HTML + Bootstrap 5 (CDN) + JS vanilla.
- **Nu se folosesc ORM-uri** (Hibernate, SQLAlchemy ORM, Django ORM etc.) - cerință explicită.

## Cerințe obligatorii (din enunțul materiei)

1. Minim 5 tabele, minim 15 înregistrări per tabelă.
2. Aplicație WEB cu interfață grafică (nu CLI).
3. Apelează **proceduri/funcții PL/SQL** stocate (nu doar SQL CRUD).
4. Minim **2 triggere** pentru automatizări.
5. Aplicația-client prinde minim **2 excepții** aruncate de PL/SQL.
6. Script automat de creare + populare tabele.
7. Algoritmi non-CRUD (recomandări, sentiment, predicții) implementați la nivel de server BD.
8. Folosire secvențe pentru auto-increment id-uri.
9. Schema să fie în BCNF (sau 4NF unde relevant).
10. Constrângeri toate 5 tipuri (PK, FK, UNIQUE, NOT NULL, CHECK).

## Structură folder

```
SGBDFilme/
  CLAUDE.md              # acest fișier
  plan.md                # plan de implementare detaliat
  README.md              # instrucțiuni rulare
  sql/
    01_schema.sql        # CREATE TABLE + sequences + constraints
    02_triggers.sql      # cele 2 triggere
    03_package_spec.sql  # specificația pachetului PL/SQL
    04_package_body.sql  # corpul pachetului PL/SQL
    05_populate.sql      # date sample (15+ per tabelă)
    99_drop_all.sql      # reset rapid pentru re-rulare
  app/
    __init__.py
    db.py                # conexiune oracledb + helper apelare proceduri
    app.py               # Flask app + routes
    templates/           # HTML
    static/              # CSS/JS
  requirements.txt
  .env.example
  .gitignore
```

## Convenții cod

- Comentarii minime; doar acolo unde codul e non-obvious sau algoritmul e complex.
- Nume tabele/coloane: snake_case, plural pentru tabele (`filme`, `actori`, `clienti`).
- Numele constrângerilor: `pk_<tab>`, `fk_<tab>_<ref>`, `uq_<tab>_<col>`, `ck_<tab>_<col>`.
- Secvențe: `seq_<tab>`.
- Pachet PL/SQL principal: `pkg_filme`.
- Excepții PL/SQL business: `RAISE_APPLICATION_ERROR(-20001..-20010, ...)`.

## Reguli colaborare

- **Implementare SIMPLĂ, basic, ca un student.** Fără over-engineering.
- **Commit-uri granulare** pe GitHub (un commit per artefact).
- **Nu menționa Claude/Anthropic** în commit messages, PR titles sau descriptions.

## Cum se rulează (sumar)

1. Oracle XE pornit local (Docker sau instalare nativă), user dedicat creat.
2. Rulezi `sql/01..05.sql` în ordine (SQL*Plus sau SQL Developer).
3. `pip install -r requirements.txt`.
4. Configurezi `.env` pe baza `.env.example` (credențiale Oracle).
5. `python -m app.app` → deschizi http://localhost:5000.

Detalii complete în README.md.
