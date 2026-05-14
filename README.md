# SGBDFilme

Scurt paragraf descriere: platformă web pentru vizualizare filme cu voturi, comentarii, recomandări personalizate (similaritate clienți) și analiză sentiment. Realizat pentru materia PSGBD, FII UAIC.

## Cerințe sistem

- Oracle Database 19c sau 21c XE (recomandat: Oracle XE 21c)
- Python 3.10+
- pip
- Conexiune la o instanță Oracle (locală sau remote)

## Setup baza de date

### Varianta 1: Oracle XE local

Instalează Oracle XE 21c. Pornește serviciul. Conectează-te ca `SYSTEM` și creează un user dedicat:

```sql
CREATE USER sgbdfilme IDENTIFIED BY parola_sigura_aici;
GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE TABLE, CREATE SEQUENCE,
      CREATE PROCEDURE, CREATE TRIGGER, CREATE VIEW TO sgbdfilme;
ALTER USER sgbdfilme QUOTA UNLIMITED ON USERS;
```

### Varianta 2: Oracle XE prin Docker (mai rapid pe Mac/Linux)

```bash
docker run -d --name oracle-xe -p 1521:1521 \
  -e ORACLE_PASSWORD=parola_oracle \
  -v oracle-data:/opt/oracle/oradata \
  gvenzl/oracle-xe:21-slim
```
(Așteaptă ~2 min să se inițializeze. Verifică `docker logs -f oracle-xe` până vezi `DATABASE IS READY TO USE!`.)
Apoi creează user-ul ca la Varianta 1.

## Rulare scripturi SQL

Conectează-te ca user-ul `sgbdfilme` (SQL Developer, SQL*Plus sau orice client) și rulează în ordine:

```
@sql/01_schema.sql
@sql/02_triggers.sql
@sql/03_package_spec.sql
@sql/04_package_body.sql
@sql/05_populate.sql
```

Pentru reset complet (dev only):
```
@sql/99_drop_all.sql
```
apoi re-rulează scripturile.

## Setup Python

```bash
python3 -m venv venv
source venv/bin/activate     # pe Mac/Linux
# venv\Scripts\activate      # pe Windows
pip install -r requirements.txt
```

## Configurare

Copiază `.env.example` în `.env`:
```bash
cp .env.example .env
```
Editează `.env` cu credențialele Oracle.

## Rulare aplicație

```bash
python -m app.app
```
Deschide http://localhost:5000

## Funcționalități

- **Catalog filme** - listare cu filtrare după categorie.
- **Detalii film** - actori, versiuni, comentarii, rating, sentiment.
- **Vizualizare** - alegi o versiune, se înregistrează în baza de date (trigger setează automat câmpul finalizat).
- **Vot + comentariu** - notă 1-5 plus text liber. Trigger recalculează ratingul filmului.
- **Recomandări personalizate** - algoritm de similaritate între clienți implementat în PL/SQL.
- **Pagină admin** - top filme, sentiment per film, predicții sezoniere.

## Cerințe PSGBD acoperite

- 9 tabele (minim 5 cerut)
- 15+ înregistrări per tabelă (script populare automată)
- Toate 5 tipuri de constrângeri folosite (PK, FK, UNIQUE, NOT NULL, CHECK)
- 2 triggere (`trg_recalc_rating`, `trg_marcheaza_finalizat`)
- Pachet PL/SQL `pkg_filme` cu 8 funcții și 2 proceduri
- Algoritmi non-CRUD: recomandări prin similaritate, analiză sentiment via keyword matching, predicții sezoniere
- Aplicație WEB cu GUI (Flask + Bootstrap 5)
- Apelare exclusivă a procedurilor/funcțiilor PL/SQL (driver `oracledb`, fără ORM)
- Prindere excepții PL/SQL (ORA-20001..-20006) cu mesaje user-friendly
- Secvențe pentru auto-increment id
- Schema în BCNF

## Structura schema

Vezi `plan.md` pentru detalii de modelare și normalizare. Pe scurt:
- `categorii` 1:N `filme` 1:N `versiuni_film` 1:N `vizualizari`
- `filme` M:N `actori` prin `film_actori`
- `clienti` 1:N `vizualizari`, 1:N `voturi`
- `voturi` referă `filme` (rating și comentarii)
- `cuvinte_sentiment` - tabelă de suport pentru analiza sentiment.

## Algoritmi implementați în PL/SQL

### Recomandări (similaritate clienți)
1. Identifică filmele votate cu nota >= 3 de clientul curent.
2. Găsește alți clienți care au votat aceleași filme cu nota ±1.
3. Calculează un scor de similaritate per pereche (client, alt_client).
4. Recomandă filmele apreciate (nota >= 4) de top-K clienți similari care **nu** au fost văzute/votate de clientul curent.

### Sentiment analysis
Pe baza unei tabele `cuvinte_sentiment` (polaritate ±1), tokenizează comentariile filmului și sumează polarităile cuvintelor matchuite.

### Predicții sezoniere
Pe baza istoricului `vizualizari`, identifică top categoriile populare în luna selectată (cross-year).

## Excepții PL/SQL prinse de aplicație

| Cod ORA  | Context                  | Mesaj UI                   |
|----------|--------------------------|----------------------------|
| -20001   | Client inexistent        | Client inexistent.         |
| -20002   | Versiune indisponibilă   | Versiune indisponibilă.    |
| -20003   | Notă invalidă            | Nota trebuie 1..5.         |
| -20004   | Film inexistent          | Film inexistent.           |
| -20005   | Lună invalidă            | Luna invalidă (1..12).     |
| -20006   | Durată invalidă          | Durata invalidă.           |

## Troubleshooting

- **`DPY-3015: password verifier`** - upgrade `oracledb` și/sau rulează `ALTER SYSTEM SET SEC_CASE_SENSITIVE_LOGON = TRUE;` pe Oracle 11g+.
- **`ORA-12541: TNS:no listener`** - serverul Oracle nu rulează; pornește serviciul / containerul Docker.
- **`Could not connect`** - verifică DSN-ul în `.env` (format `host:port/service_name`, ex. `localhost:1521/XEPDB1` pentru XE Container DB).
- **Triggere nu compilează** - asigură-te că ai rulat `01_schema.sql` înainte de `02_triggers.sql`.

## Autor

Proiect individual realizat în cadrul materiei PSGBD, Facultatea de Informatică, UAIC Iași.
