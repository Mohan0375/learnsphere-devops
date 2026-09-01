# Troubleshooting

## 1. Tests fail
**Symptoms:** GitHub Actions fails in `Automated tests`.

**Checks:**
```bash
pytest -q
pip install -r requirements.txt
```
Fix the application/test failure before attempting deployment.

## 2. Docker build fails
Check `Dockerfile`, `requirements.txt`, and GitHub Actions build logs.

## 3. EC2 SSH failure
Verify `EC2_HOST`, `EC2_USER`, SSH key permissions, security-group port 22, and `known_hosts`.

## 4. GHCR pull denied
Verify `GHCR_USERNAME` and `GHCR_TOKEN`. The token must be allowed to read the package.

## 5. Container starts but health check fails
Run:
```bash
docker logs learnsphere --tail 200
curl -i http://127.0.0.1:5000/health
```
Check RDS connectivity, credentials, security groups, and environment variables.

## 6. RDS connection refused
Verify:
- RDS is available.
- EC2 can reach RDS port 5432.
- RDS security group permits the EC2 security group.
- `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, and `DB_PORT` are correct.

## 7. Port 5000 already in use
```bash
sudo ss -ltnp | grep :5000
docker ps
```
Stop the conflicting service or change the published port.

## 8. Rollback says no previous image
This means there was no successful deployment recorded yet. Deploy a known-good version first or manually set the approved previous image.

## 9. Notification skipped
If `SLACK_WEBHOOK_URL` is not configured, `notify.sh` intentionally exits successfully. Configure the secret if Slack evidence is required.
