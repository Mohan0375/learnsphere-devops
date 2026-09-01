# LearnSphere DevOps Architecture

## Objective
Automate testing, container build, deployment, health validation, notification and rollback for the LearnSphere Flask LMS.

## Components
- GitHub repository: source control and pull requests.
- GitHub Actions: CI/CD orchestration.
- pytest: automated application tests.
- Docker/GHCR: immutable application images tagged with the Git commit SHA.
- Ubuntu EC2: deployment host.
- Amazon RDS PostgreSQL: application database.
- `/health`: deployment health endpoint.
- Optional Slack webhook: pipeline notifications.

## Release flow
1. Push to `main`.
2. GitHub Actions runs pytest.
3. A successful test job builds and pushes a commit-tagged image.
4. Deployment host pulls the exact image.
5. Container is recreated with the new image.
6. `/health` is polled.
7. If healthy, deployment succeeds.
8. If unhealthy, the previous image is restored and a failure/rollback notification is sent.
