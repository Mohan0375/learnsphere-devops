# LearnSphere Deployment Guide

## Prerequisites
- GitHub repository with Actions enabled.
- Ubuntu EC2 instance reachable by SSH.
- Docker and Docker Compose plugin.
- Existing RDS PostgreSQL database.
- GitHub Container Registry access.

## 1. Prepare the EC2 host

Run the repository's deployment setup script on the host:

```bash
./scripts/server_setup.sh
```

Create `/opt/learnsphere/.env` from `.env.example` and populate the RDS values.

Never commit `.env`.

## 2. Configure GitHub Actions secrets

Create these repository/environment secrets:

- `EC2_HOST` — EC2 public DNS/IP.
- `EC2_USER` — e.g. `ubuntu`.
- `EC2_SSH_PRIVATE_KEY` — SSH private key.
- `GHCR_USERNAME` — GitHub username.
- `GHCR_TOKEN` — GitHub token/PAT with permission to pull the package.
- `SLACK_WEBHOOK_URL` — optional Slack incoming webhook.

Prefer a GitHub `production` environment and protect it with required reviewers for production deployments.

## 3. Run the pipeline

Push to `main` or manually run `LearnSphere CI/CD` from the Actions tab.

The workflow:
- runs tests,
- builds the Docker image,
- pushes the image using the commit SHA,
- copies deployment scripts,
- deploys,
- waits for `/health`,
- rolls back automatically on failure,
- sends an optional notification.

## 4. Verify manually

```bash
curl http://<EC2_HOST>:5000/health
docker ps
docker logs learnsphere
cat /opt/learnsphere/.current_image
```
