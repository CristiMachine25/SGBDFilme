import os
import oracledb
from dotenv import load_dotenv

load_dotenv()

# Fetch CLOB/BLOB columns as plain strings/bytes eagerly. Without this,
# Oracle returns lazy LOB objects that fail with DPY-1001 once the
# owning connection is closed (e.g. during Jinja template rendering).
oracledb.defaults.fetch_lobs = False

USER = os.getenv("ORACLE_USER")
PASSWORD = os.getenv("ORACLE_PASSWORD")
DSN = os.getenv("ORACLE_DSN")

def get_conn():
    return oracledb.connect(user=USER, password=PASSWORD, dsn=DSN)

def call_func_cursor(func_name, *args):
    """Call PL/SQL function returning SYS_REFCURSOR. Returns list of dicts."""
    with get_conn() as conn:
        with conn.cursor() as cur:
            ref = cur.var(oracledb.DB_TYPE_CURSOR)
            placeholders = ",".join(f":{i+2}" for i in range(len(args)))
            sql = f"BEGIN :1 := pkg_filme.{func_name}({placeholders}); END;" if args else f"BEGIN :1 := pkg_filme.{func_name}(); END;"
            cur.execute(sql, [ref, *args])
            rc = ref.getvalue()
            cols = [c[0].lower() for c in rc.description]
            return [dict(zip(cols, row)) for row in rc]

def call_func_scalar(func_name, *args):
    """Call PL/SQL function returning scalar."""
    with get_conn() as conn:
        with conn.cursor() as cur:
            ret = cur.var(str)
            placeholders = ",".join(f":{i+2}" for i in range(len(args)))
            sql = f"BEGIN :1 := pkg_filme.{func_name}({placeholders}); END;" if args else f"BEGIN :1 := pkg_filme.{func_name}(); END;"
            cur.execute(sql, [ret, *args])
            return ret.getvalue()

def call_proc(proc_name, *args):
    """Call PL/SQL procedure. Lets DatabaseError propagate so caller can inspect."""
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.callproc(f"pkg_filme.{proc_name}", list(args))
        conn.commit()

def fetch_all(sql, params=None):
    """Plain SELECT helper for simple queries (categorii, clienti dropdowns)."""
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute(sql, params or [])
            cols = [c[0].lower() for c in cur.description]
            return [dict(zip(cols, row)) for row in cur]
