# Architecto IaC Fixture

Small multi-format IaC repository for testing Architecto IaC Import, IaC Explorer, drift/compliance parsing, security scan, cost scan, and AI summary flows.

Do not run this infrastructure. Files are intentionally simple and include safe mock values so import tools can parse, scan, and explain them without cloud credentials.

## What This Repo Tests

- Terraform detection through `terraform/*.tf`
- Kubernetes detection through `k8s/*.yaml`
- Helm detection through `helm/Chart.yaml`, `helm/values.yaml`, and templates
- CloudFormation detection through `cloudformation/template.yaml`
- Bicep detection through `bicep/main.bicep`
- ARM detection through `arm/template.json`
- Dockerfile detection through `docker/Dockerfile`
- Ansible detection through `ansible/playbook.yml`
- Pulumi project detection through `pulumi/Pulumi.yaml`
- Terragrunt detection through `terragrunt/terragrunt.hcl`
- GitOps signals through `.github/workflows/iac.yml`, `.gitlab-ci.yml`, `argocd/application.yaml`, and `flux/kustomization.yaml`
- Governance handoff notes through `ops/governance-scenarios.md`

## Architecto Import Paths

Use these paths in IaC Import:

- Blank path: imports all supported files.
- `terraform/`: imports Terraform only.
- `k8s/`: imports Kubernetes only.
- `helm/`: imports Helm only.
- `cloudformation/`: imports CloudFormation only.
- `bicep/`: imports Bicep only.
- `arm/`: imports ARM only.
- `docker/`: imports Dockerfile only.
- `ansible/`: imports Ansible only.
- `pulumi/`: imports Pulumi marker only.
- `terragrunt/`: imports Terragrunt only.

## Expected Architecto Result

Successful import should show files greater than zero and events through detecting, cloning, parsing, security, cost, AI, and finalizing. Security tools should report findings because this fixture intentionally includes open demo network access, public storage, unencrypted demo storage/database resources, wildcard IAM, and a privileged Kubernetes workload.

After import, open IaC Orchestration to inspect repositories, modules, dependency graph, security, cost analysis, GitOps, and ADR flows. For Infra Graph, click Rebuild after import so persisted desired-state records materialize as graph nodes. Cloud Inventory, ClickOps Events, and Drift Reconciliation still require live cloud/event/drift integrations; this repo supplies only the desired-state side.

If import shows zero files, selected GitHub repo/path did not contain a supported IaC file or source detection failed.
