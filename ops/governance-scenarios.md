# Architecto Governance Scenarios

Use this repo as a compact desired-state fixture. It is not meant for apply.

## Import And Orchestration

- Import with blank path to detect Terraform, Kubernetes, Helm, CloudFormation, Bicep, ARM, Dockerfile, Ansible, Pulumi, and Terragrunt files.
- Import with `terraform/` to focus on graph edges, cost estimates, imports, moved blocks, provider aliases, and module calls.
- Open IaC Orchestration after import, then refresh repositories and expand the imported snapshot.
- Use Dependency Graph to verify module-to-resource edges.
- Use Security to verify wide security group, public S3 ACL, unencrypted storage/database, and wildcard IAM policy style findings.
- Use Cost Analysis to verify EC2, RDS, storage, and load balancer style cost categories.

## Infra Graph

- After import succeeds, Infra Graph still needs materialization. Open Governance > Infra Graph and click Rebuild.
- Import Desired State and Run Orchestration Scan should be Ready from this repo.
- Cloud Inventory, ClickOps Events, and Drift Reconciliation require runtime cloud evidence, not only Git files.

## Expected Missing Evidence

- Cloud Inventory needs configured cloud account discovery.
- ClickOps Events need cloud audit events such as CloudTrail or Activity Logs.
- Drift Reconciliation needs an actual-vs-desired drift run.

## Intended Findings

- `terraform/aws_security_group.web` allows SSH from `0.0.0.0/0`.
- `terraform/aws_s3_bucket_acl.logs_public_read` is intentionally public.
- `terraform/aws_ebs_volume.legacy_data` is intentionally unencrypted.
- `terraform/aws_db_instance.orders` is intentionally unencrypted and contains a fake demo password.
- `k8s/deployment.yaml` intentionally runs as UID 0 with privilege escalation allowed.
