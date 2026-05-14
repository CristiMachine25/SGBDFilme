import os
from flask import Flask, render_template, request, redirect, url_for, session, flash
from dotenv import load_dotenv
import oracledb
from . import db

load_dotenv()

app = Flask(__name__)
app.secret_key = os.getenv("FLASK_SECRET_KEY", "dev-key")


def parse_oracle_error(e):
    """Extract Oracle business error -20001..-20009 message. Returns user-friendly string."""
    msg = str(e)
    if "ORA-20001" in msg:
        return "Client inexistent."
    if "ORA-20002" in msg:
        return "Versiune indisponibilă."
    if "ORA-20003" in msg:
        return "Nota trebuie sa fie intre 1 si 5."
    if "ORA-20004" in msg:
        return "Film inexistent."
    if "ORA-20005" in msg:
        return "Luna invalida (1..12)."
    if "ORA-20006" in msg:
        return "Durata invalida."
    return "Eroare baza de date: " + msg.split("\n")[0]


@app.route("/")
def index():
    categ_filter = request.args.get("categorie")
    if categ_filter:
        rows = db.fetch_all(
            "SELECT f.id, f.titlu, f.an_lansare, c.nume AS categorie, f.rating_mediu, f.nr_voturi "
            "FROM filme f JOIN categorii c ON f.categorie_id = c.id "
            "WHERE c.nume = :1 ORDER BY f.titlu",
            [categ_filter])
    else:
        rows = db.fetch_all(
            "SELECT f.id, f.titlu, f.an_lansare, c.nume AS categorie, f.rating_mediu, f.nr_voturi "
            "FROM filme f JOIN categorii c ON f.categorie_id = c.id ORDER BY f.titlu")
    categs = db.fetch_all("SELECT nume FROM categorii ORDER BY nume")
    return render_template("index.html", filme=rows, categorii=categs, selected=categ_filter)


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        client_id = request.form.get("client_id")
        if client_id:
            session["client_id"] = int(client_id)
            session["client_nume"] = request.form.get("client_nume", "")
            flash("Logat ca " + request.form.get("client_nume", ""), "success")
            return redirect(url_for("index"))
    clienti = db.fetch_all(
        "SELECT id, nume || ' ' || prenume AS nume_complet FROM clienti ORDER BY nume")
    return render_template("login.html", clienti=clienti)


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))


@app.route("/film/<int:film_id>")
def film_detail(film_id):
    try:
        detalii = db.call_func_cursor("f_film_detalii", film_id)
    except oracledb.DatabaseError as e:
        flash(parse_oracle_error(e), "danger")
        return redirect(url_for("index"))
    if not detalii:
        flash("Film inexistent.", "danger")
        return redirect(url_for("index"))
    actori = db.call_func_cursor("f_actori_film", film_id)
    versiuni = db.call_func_cursor("f_versiuni_film", film_id)
    comentarii = db.call_func_cursor("f_comentarii_film", film_id)
    sentiment = db.call_func_scalar("f_sentiment_film", film_id)
    return render_template("film.html",
        film=detalii[0], actori=actori, versiuni=versiuni,
        comentarii=comentarii, sentiment=sentiment)


@app.route("/vizualizeaza", methods=["POST"])
def vizualizeaza():
    if "client_id" not in session:
        flash("Trebuie sa fii logat.", "warning")
        return redirect(url_for("login"))
    versiune_id = int(request.form["versiune_id"])
    film_id = int(request.form["film_id"])
    durata = int(request.form.get("durata", 90))
    try:
        db.call_proc("p_inregistreaza_vizualizare", session["client_id"], versiune_id, durata)
        flash("Vizualizare inregistrata.", "success")
    except oracledb.DatabaseError as e:
        flash(parse_oracle_error(e), "danger")
    return redirect(url_for("film_detail", film_id=film_id))


@app.route("/voteaza", methods=["POST"])
def voteaza():
    if "client_id" not in session:
        flash("Trebuie sa fii logat.", "warning")
        return redirect(url_for("login"))
    film_id = int(request.form["film_id"])
    try:
        nota = int(request.form["nota"])
    except (TypeError, ValueError):
        flash("Nota invalida.", "danger")
        return redirect(url_for("film_detail", film_id=film_id))
    comentariu = request.form.get("comentariu") or None
    try:
        db.call_proc("p_voteaza", session["client_id"], film_id, nota, comentariu)
        flash("Vot inregistrat.", "success")
    except oracledb.DatabaseError as e:
        flash(parse_oracle_error(e), "danger")
    return redirect(url_for("film_detail", film_id=film_id))


@app.route("/recomandari")
def recomandari():
    if "client_id" not in session:
        flash("Trebuie sa fii logat pentru recomandari.", "warning")
        return redirect(url_for("login"))
    try:
        rec = db.call_func_cursor("f_recomandari", session["client_id"], 10)
    except oracledb.DatabaseError as e:
        flash(parse_oracle_error(e), "danger")
        rec = []
    return render_template("recomandari.html", recomandari=rec)


@app.route("/admin")
def admin():
    top = db.call_func_cursor("f_top_filme", 10)
    luna = int(request.args.get("luna", 12))
    try:
        predictii = db.call_func_cursor("f_predictie_sezon", luna)
    except oracledb.DatabaseError as e:
        flash(parse_oracle_error(e), "danger")
        predictii = []
    # sentiment per top film
    sentiment_data = []
    for f in top:
        try:
            s = db.call_func_scalar("f_sentiment_film", f["id"])
        except oracledb.DatabaseError:
            s = "n/a"
        sentiment_data.append({**f, "sentiment": s})
    return render_template("admin.html", top=sentiment_data, predictii=predictii, luna=luna)


if __name__ == "__main__":
    debug = os.getenv("FLASK_DEBUG", "0") == "1"
    app.run(host="127.0.0.1", port=5000, debug=debug)
