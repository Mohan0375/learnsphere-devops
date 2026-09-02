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
CI/CD deployment verification


## DevOps Implementation

LearnSphere has been enhanced with a complete CI/CD deployment workflow.

### CI/CD Pipeline

```text
Developer
   |
   | git push
   v
GitHub Repository
   |
   v
GitHub Actions
   |
   +----> Automated Tests
   |          |
   |          v
   |       pytest
   |
   +----> Docker Build
   |          |
   |          v
   |      GitHub Container Registry
   |
   +----> Deployment
              |
              v
          AWS EC2
              |
              v
       Docker Compose
              |
        +-----+-----+
        |           |
        v           v
   LearnSphere   PostgreSQL
        |
        v
   Health Check

Technologies Used
Git & GitHub — source code management
GitHub Actions — CI/CD automation
Python / Flask — application
Pytest — automated testing
Docker — containerization
Docker Compose — application and database orchestration
GitHub Container Registry (GHCR) — Docker image registry
AWS EC2 — deployment server
PostgreSQL — application database
Bash — deployment and rollback automation
CI/CD Workflow

The GitHub Actions pipeline performs the following:

Runs automated pytest tests.
Builds the LearnSphere Docker image.
Publishes the image to GHCR.
Connects to the AWS EC2 server through SSH.
Pulls the versioned Docker image.
Deploys the application using Docker Compose.
Performs an application/database health check.
Automatically attempts rollback when deployment verification fails.
Deployment

The application is deployed to an AWS EC2 Ubuntu server using Docker Compose.

The application exposes:

http://<EC2-PUBLIC-IP>:5000

Health endpoint:

http://<EC2-PUBLIC-IP>:5000/health

Example health response:

{
  "database": "healthy",
  "status": "healthy"
}
Rollback

Deployments maintain the previously working Docker image.

Rollback is automated using:

./scripts/rollback.sh

The rollback process:

Retrieves the previously deployed image.
Pulls the image from GHCR.
Recreates the application container.
Keeps the PostgreSQL database running.
Restores the previous application version.
Deployment Evidence

The project has been successfully validated with:

GitHub Actions CI/CD pipeline — successful
Automated tests — passed
Docker image build and GHCR publication — successful
AWS EC2 deployment — successful
LearnSphere container — healthy
PostgreSQL container — healthy
Application health check — successful
Rollback procedure — successfully tested
