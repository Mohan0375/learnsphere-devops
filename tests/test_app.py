from unittest.mock import MagicMock, patch
import pytest

from app import app


@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_home_page(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"LearnSphere" in response.data


def test_health_returns_200_when_database_is_available(client):
    fake_conn = MagicMock()
    fake_cur = fake_conn.cursor.return_value.__enter__.return_value
    fake_cur.fetchone.return_value = (1,)

    # get_connection() is mocked so CI does not require a real PostgreSQL server.
    with patch("app.get_connection", return_value=fake_conn):
        response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"


def test_health_returns_503_when_database_is_unavailable(client):
    with patch("app.get_connection", side_effect=Exception("database unavailable")):
        response = client.get("/health")

    assert response.status_code == 503
    assert response.get_json()["status"] == "unhealthy"


def test_students_query(client):
    fake_conn = MagicMock()
    fake_cur = fake_conn.cursor.return_value
    fake_cur.fetchall.return_value = [(1, "Student", "student@example.com", "student")]

    with patch("app.get_connection", return_value=fake_conn):
        response = client.get("/students")

    assert response.status_code == 200
    fake_cur.execute.assert_called_once_with("SELECT * FROM users;")


def test_courses_query(client):
    fake_conn = MagicMock()
    fake_cur = fake_conn.cursor.return_value
    fake_cur.fetchall.return_value = [(1, "DevOps", "Trainer")]

    with patch("app.get_connection", return_value=fake_conn):
        response = client.get("/courses")

    assert response.status_code == 200
    fake_cur.execute.assert_called_once_with("SELECT * FROM courses;")
