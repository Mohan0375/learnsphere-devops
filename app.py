import os
from flask import Flask, jsonify, render_template
import psycopg2
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_PORT = os.getenv("DB_PORT", "5432")


def get_connection():
    """Create a PostgreSQL connection using environment variables."""
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        port=DB_PORT,
        connect_timeout=5,
    )


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/health")
def health():
    """Deployment health endpoint. Checks application and database connectivity."""
    try:
        conn = get_connection()
        with conn.cursor() as cur:
            cur.execute("SELECT 1;")
            cur.fetchone()
        conn.close()
        return jsonify(status="healthy", database="healthy"), 200
    except Exception as exc:
        app.logger.exception("Health check failed")
        return jsonify(status="unhealthy", database="unavailable", error=str(exc)), 503


@app.route("/students")
def students():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM users;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("students.html", students=rows)


@app.route("/courses")
def courses():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM courses;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("courses.html", courses=rows)


@app.route("/enrollments")
def enrollments():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT e.enrollment_id, e.user_id, e.course_id,
               u.full_name, c.course_name
        FROM enrollments e
        JOIN users u ON e.user_id = u.user_id
        JOIN courses c ON e.course_id = c.course_id;
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("enrollments.html", enrollments=rows)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
