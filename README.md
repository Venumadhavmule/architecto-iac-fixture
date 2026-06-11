# Architecto IaC Fixture

Small multi-format IaC repository for testing Architecto IaC Import, IaC Explorer, drift/compliance parsing, security scan, cost scan, and AI summary flows.

Do not run this infrastructure. Files are intentionally simple and include safe mock values so import tools can parse, scan, and explain them without cloud credentials.

## What This Repo Tests

- Terraform detection through `terraform/*.tf`
- Kubernetes detection through `k8s/*.yaml`
- Helm detection through `helm/Chart.yaml`, `helm/values.yaml`, and templates
- CloudFormation detection through `cloudformation/template.yaml`
- Bicep detection through `bicep/main.bicep`
- Dockerfile detection through `docker/Dockerfile`
- Ansible detection through `ansible/playbook.yml`
- Pulumi project detection through `pulumi/Pulumi.yaml`

## Architecto Import Paths

Use these paths in IaC Import:

- Blank path: imports all supported files.
- `terraform/`: imports Terraform only.
- `k8s/`: imports Kubernetes only.
- `helm/`: imports Helm only.
- `cloudformation/`: imports CloudFormation only.
- `bicep/`: imports Bicep only.
- `docker/`: imports Dockerfile only.
- `ansible/`: imports Ansible only.
- `pulumi/`: imports Pulumi marker only.

## Expected Architecto Result

Successful import should show files greater than zero and events through detecting, cloning, parsing, security, cost, AI, and finalizing. Security tools may report findings because this fixture intentionally includes open demo security group and non-root hardening examples.

If import shows zero files, selected GitHub repo/path did not contain a supported IaC file or source detection failed.

