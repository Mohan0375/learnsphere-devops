# Rollback Runbook

## Automatic rollback
A failed deployment health check causes the workflow to execute `scripts/rollback.sh`.

The deployment script stores the previously running image in:

`/opt/learnsphere/.rollback/previous_image`

The rollback script pulls that image and recreates the container.

## Manual rollback

On the EC2 host:

```bash
cd /opt/learnsphere
./scripts/rollback.sh
./scripts/health_check.sh http://127.0.0.1:5000/health
```

## Verify

```bash
docker ps
docker logs learnsphere --tail 100
curl http://127.0.0.1:5000/health
cat .current_image
```

## Recovery rule
Do not delete the previous image until the new deployment has passed its health check and the release is considered stable.
