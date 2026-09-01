# LearnSphere DevOps Assignment Deliverables

## Implementation
- Flask LMS retained from the original project.
- `/health` deployment endpoint with PostgreSQL connectivity check.
- pytest automated tests.
- Dockerfile and Docker Compose deployment.
- GitHub Actions CI/CD workflow.
- GHCR image publishing with immutable commit-SHA tags.
- EC2 deployment over SSH.
- Post-deployment health checks.
- Automatic rollback to the previous image after a failed deployment.
- Optional Slack pipeline notifications.

## Configuration / Code
- `.github/workflows/lms-ci-cd.yml`
- `Dockerfile`
- `docker-compose.yml`
- `scripts/*.sh`
- `requirements.txt`
- `.env.example`

## Evidence
See `docs/evidence.md` for the exact screenshots to capture after running the GitHub Actions pipeline.

## Test Cases
See `docs/test-cases.md`.

## Troubleshooting
See `docs/troubleshooting.md`.

## Documentation
- `README.md`
- `docs/architecture.md`
- `docs/deployment-guide.md`
- `docs/rollback-runbook.md`

## Important security action
The source archive supplied for this project contained a database password in `.env`. The delivered project removes that file and adds `.env` to `.gitignore`. If the credential is active, rotate it before using the repository.
