# Terraform Azure Infrastructure

This repository contains reusable Terraform modules and environment configurations for deploying Azure infrastructure. It is designed to support multiple environments (e.g., `dev`, `prod`) using a modular and scalable approach.

## Project Structure

```
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── prod/
│       ├── main.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── variables.tf
└── modules/
    ├── app_service/
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── readme.md
    │   └── variables.tf
    ├── app_service_plan/
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── readme.md
    │   └── variables.tf
    ├── database/
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── readme.md
    │   └── variables.tf
    ├── key_vault/
    │   ├── main.tf
    │   ├── output.tf
    │   ├── rbac.tf
    │   ├── readme.md
    │   └── variable.tf
    ├── networking/
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── readme.md
    │   └── variables.tf
    └── storage/
        ├── main.tf
        ├── outputs.tf
        ├── readme.md
        └── variables.tf
```

### Environments

- **dev/**: Development environment configuration
- **prod/**: Production environment configuration

Each environment contains its own `main.tf`, `provider.tf`, `terraform.tfvars`, and `variables.tf` for isolated deployments.

### Modules

- **app_service/**: Azure App Service resources
- **app_service_plan/**: Azure App Service Plan resources
- **database/**: Database resources (e.g., Azure SQL, PostgreSQL)
- **key_vault/**: Azure Key Vault resources
- **networking/**: Networking resources (VNet, subnets, etc.)
- **storage/**: Azure Storage resources

Each module is self-contained and reusable, with its own variables and outputs.

### Usage

1. **Install Terraform**: Ensure you have [Terraform](https://www.terraform.io/downloads.html) installed.
2. **Configure Azure Credentials**: Authenticate with Azure CLI or set environment variables for service principal.
3. **Select Environment**:
	 ```
	 cd environments/dev   # or environments/prod
	 ```
4. **Initialize Terraform**:
	 ```
	 terraform init
	 ```
5. **Plan and Apply**:
	 ```
	 terraform plan
	 terraform apply
	 ```

### Customization

Edit the `terraform.tfvars` and `variables.tf` files in each environment to customize resource parameters. Modules can be extended or reused as needed.

### Notes

- Follow best practices for managing secrets and state files.
- Use remote state backends for team collaboration.

---
For more details, see the documentation in each module and environment folder.
```

## Setup Instructions

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Azure CLI (`az`) authenticated to your subscription
- Sufficient permissions to create resources in the target Azure subscription
- **Remote State Prerequisite:** The Azure Storage Account and Blob Container for the Terraform state file must be created before running `terraform init`. Ensure the storage account and container specified in your backend configuration exist.

### 1. Clone the Repository

```powershell
git clone <this-repo-url>
cd tf-azure-infra
```

### 2. Select Environment

Navigate to the desired environment directory (e.g., `dev` or `prod`):

```powershell
cd environments\dev  # or environments\prod
```

### 3. Configure Variables

Edit the `terraform.tfvars` file in the chosen environment directory to set environment-specific values (e.g., resource names, sizes, locations).

### 4. Initialize Terraform

```powershell
terraform init
```

### 5. Plan the Deployment

```powershell
terraform plan -out=tfplan
```

### 6. Apply the Deployment

```powershell
terraform apply tfplan
```

## Multi-Environment Design

This repository is structured to support multiple environments (such as `dev` and `prod`) by:

- **Environment Isolation:** Each environment has its own directory under `environments/` with separate Terraform configuration and variable files.
- **Reusable Modules:** The `modules/` directory contains modular Terraform code for common Azure resources (compute, networking, storage, etc.), which are referenced from each environment's `main.tf`.
- **Custom Variables:** Each environment can override variables via its own `terraform.tfvars` and `variables.tf` files, allowing for different configurations (e.g., resource sizes, tags, locations) per environment.
- **Provider Configuration:** Each environment can specify its own provider settings in `provider.tf` (e.g., subscription, region).

This design enables safe, repeatable, and isolated deployments for different stages (development, production, etc.) using the same codebase.

## Extending the Infrastructure

To add new resources or modules:

1. Create a new module under `modules/` or update an existing one.
2. Reference the module in the appropriate environment's `main.tf`.
3. Add or update variables as needed in `variables.tf` and `terraform.tfvars`.
4. Re-run `terraform init`, `plan`, and `apply` in the environment directory.


## Architectural Reasoning

This infrastructure is designed to provide a secure, scalable, and maintainable Azure environment for web applications, supporting multiple environments (dev, prod) and following Infrastructure-as-Code (IaC) best practices. The architecture is based on the following principles and choices:

- **Virtual Network with Segmented Subnets:**
	- The use of a single Azure Virtual Network (VNet) with dedicated subnets for frontend, backend, and storage ensures network isolation and security boundaries between application tiers.
	- Subnets (Frontend, Backend, Storage) allow for fine-grained network security rules and facilitate internal-only communication where needed (e.g., backend API, database access).

- **App Service (Frontend & Backend):**
	- Azure App Service is chosen for both frontend and backend workloads due to its managed nature, built-in scaling, and integration with Azure DevOps and CI/CD pipelines.
	- Deploying frontend and backend in separate subnets supports the principle of least privilege and allows for independent scaling and management.

- **Azure SQL Database:**
	- Provides a fully managed, scalable, and secure relational database service with built-in high availability and backup capabilities.
	- Placed in the backend subnet to restrict access to only the backend App Service, reducing the attack surface.

- **Azure Blob Storage:**
	- Used for static asset storage, such as images or documents, with secure access from the backend or directly from the frontend as needed.
	- Isolated in its own subnet to control access and apply network security rules.

- **Environment Configuration & IaC Automation:**
	- All resources are provisioned and managed via Terraform, ensuring repeatability, version control, and easy environment replication.
	- Environment variables and secrets are injected per environment, supporting secure and flexible deployments for dev, prod, or other stages.

**Patterns and Best Practices:**
- Modular Terraform code for reusability and maintainability
- Environment isolation for safe parallel development and production deployments
- Principle of least privilege and network segmentation for security
- Use of managed Azure services to reduce operational overhead

This design enables teams to deploy secure, consistent, and scalable infrastructure across multiple environments with minimal manual intervention.

## Notes

- Always review the Terraform plan before applying changes.
- Use remote state backends and state locking for team collaboration (not included by default).
- For sensitive values, consider using Azure Key Vault and Terraform secrets management.

---

## Issues and Questions (Feedback Loop)

Below is a running list of issues encountered and questions that arose during the development and deployment of this infrastructure. This section is intended to facilitate feedback, knowledge sharing, and continuous improvement.

### Issues Encountered
- 403 Forbidden error when accessing Key Vault secrets from Terraform (resolved by adding Key Vault Secrets User RBAC assignment to the Terraform principal).
- Ensure correct Azure credentials and permissions are set for all resources and environments.
- State file management: Use remote state for collaboration to avoid conflicts.
- Provider version mismatches between environments causing unexpected errors.
- Terraform plan/apply fails due to missing or misconfigured variables.
- Delays in resource provisioning due to Azure API throttling or quota limits.

_Please add more issues as you encounter them to help improve this project for everyone!_

---
**Author:** [Joshua ]

