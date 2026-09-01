# LearnSphere Test Cases

| ID | Scenario | Expected result |
|---|---|---|
| TC-01 | Load dashboard | HTTP 200 and LearnSphere text |
| TC-02 | Healthy database | `/health` returns 200 and `healthy` |
| TC-03 | Database unavailable | `/health` returns 503 and `unhealthy` |
| TC-04 | Students endpoint | Query executes and page returns 200 |
| TC-05 | Courses endpoint | Query executes and page returns 200 |
| TC-06 | Pytest failure | CI stops before build/deploy |
| TC-07 | Healthy deployment | Deployment remains on new SHA |
| TC-08 | Health-check failure | Rollback script restores previous SHA |
| TC-09 | Missing previous image | Rollback reports clear error |
| TC-10 | Slack secret absent | Pipeline completes without notification error |

## Failure injection
For a controlled rollback demonstration, temporarily make `/health` return HTTP 503 in a test branch, deploy that branch in a non-production environment, and verify that the rollback step restores the prior image. Revert the test change after collecting evidence.
