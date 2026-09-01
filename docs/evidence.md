# Evidence / Screenshot Checklist

Capture these screenshots from GitHub Actions and the deployment host:

1. **Workflow overview** — `LearnSphere CI/CD` run showing all jobs.
2. **Automated tests** — pytest step with all tests passing.
3. **Build and publish** — Docker build/push step showing the commit SHA tag.
4. **Deployment** — deployment step showing the image SHA.
5. **Health check** — successful `/health` output.
6. **Successful notification** — Slack/email/GitHub evidence if configured.
7. **Failure demonstration** — controlled health-check failure.
8. **Rollback** — workflow showing `Roll back if deployment failed`.
9. **Post-rollback health** — `/health` returns healthy after restoration.
10. **Server state** — `docker ps` and `.current_image` showing the restored image.

Do not capture passwords, private keys, database credentials, tokens, or `.env` contents.
