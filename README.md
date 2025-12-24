# Terraform CI/CD Pipeline (BYOD Project)

**Automated infrastructure deployment using Jenkins, Terraform, and AWS.**

### Key Tasks Completed
* **Task 1 (Webhook):** Automatic build triggers via GitHub Webhooks & Ngrok.
* **Task 2 (Security):** Credential masking and `TF_IN_AUTOMATION` setup.
* **Task 3 (Inspection):** Automated logging of `main.tfvars` variables.
* **Task 4 (Plan):** Automated `terraform plan` generation.
* **Task 5 (Gate):** Manual approval stage implemented in `Jenkinsfile`.

### Project Structure
* `Jenkinsfile`: Pipeline-as-code definition.
* `main.tf`: AWS resource configuration.
* `*.tfvars`: Environment-specific variables (`main` vs `dev`).

### Pipeline Stages
1.  **Checkout:** Pulls latest code from GitHub.
2.  **Init & Inspect:** Initializes Terraform and logs variables.
3.  **Plan:** Generates an execution plan.
4.  **Manual Gate:** Pauses for human approval before finishing.