# LearnSphere LMS — DevOps CI/CD Demo

A small Flask + PostgreSQL LMS used to demonstrate DevOps practices.

## Features
- Dashboard, students, courses and enrollments.
- PostgreSQL connectivity.
- `/health` endpoint for deployment health checks.
- Automated pytest suite.
- Docker image build.
- GitHub Actions CI/CD.
- GHCR image publishing.
- EC2 deployment.
- Automatic rollback after failed health checks.
- Optional Slack notifications.

## Quick local run

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# edit .env with a test database
flask --app app run --host 0.0.0.0 --port 5000
```

Run tests:

```bash
pytest -q
```

Build/run container:

```bash
docker build -t learnsphere:local .
docker compose up -d
curl http://127.0.0.1:5000/health
```

## CI/CD
See `docs/architecture.md` and `docs/deployment-guide.md`.

## Security note
The original project archive contained a real-looking database password in `.env`. This DevOps version deliberately removes `.env` from the project and ignores it in Git. **If that credential is still active, rotate it immediately in PostgreSQL/AWS and replace it with a GitHub secret or a securely managed deployment-host environment variable.**

## Deliverables
- Implementation: `app.py`, Dockerfile, scripts, workflow.
- Configuration: `docker-compose.yml`, `.env.example`.
- Tests: `tests/`.
- Evidence checklist: `docs/evidence.md`.
- Test cases: `docs/test-cases.md`.
- Troubleshooting: `docs/troubleshooting.md`.
- Rollback runbook: `docs/rollback-runbook.md`.
