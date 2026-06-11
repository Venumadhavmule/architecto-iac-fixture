# Architecto Test Plan

## Import Smoke Test

1. Push this folder to a GitHub repository.
2. In Architecto, open `Automate > IaC Import`.
3. Connect GitHub OAuth.
4. Select this repository.
5. Keep path empty for full import, or set one path from README.
6. Enable security scan, cost analysis, and AI analysis.
7. Start import.

Expected:

- Repository list loads from persisted GitHub OAuth connection.
- Job leaves `QUEUED` in local dev when local worker fallback is enabled.
- Files count is greater than zero.
- Empty unsupported repo shows clear "No supported IaC files found" message, not fake success.
- Later visits should reuse existing connection until token is revoked or encryption key changes.
- Security findings include at least one wide network, public storage, unencrypted storage, or privileged workload item.
- Cost analysis includes compute, database, storage, and Kubernetes/service style resource categories.
- Dependency graph has module-to-resource edges and Terraform dependency hints.

## Feature Handoff

- IaC Import validates source fetch, parser coverage, scans, and persisted import artifacts.
- IaC Explorer should use completed import artifacts to browse parsed resources/files.
- Governance features should consume inventory/findings/events from completed import or cloud discovery jobs.

## Infra Graph Check

1. Finish a full import.
2. Open `Govern > Infra Graph`.
3. If graph says rebuild is needed, click `Rebuild`.
4. Verify imported repository, IaC modules, desired resources, import job, and parsed files become graph nodes.
5. Treat Cloud Inventory, ClickOps Events, and Drift Reconciliation as separate integrations. This repo cannot make those ready by itself.

Expected:

- Import Desired State: Ready.
- Run Orchestration Scan: Ready.
- Connect Cloud Inventory: Missing until cloud account discovery is configured.
- Enable ClickOps Events: Missing until cloud audit events are ingested.
- Run Drift Reconciliation: Missing until drift scan data exists.
