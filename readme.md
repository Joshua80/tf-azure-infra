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

The architecture is designed for secure, scalable, and efficient web application hosting in Azure, as illustrated in the diagram above:

- **Virtual Network (VNET):** All resources are deployed within a single Azure VNET to ensure network isolation and control.

- **Web Subnet:** Hosts both the Frontend and Backend App Services. The Frontend App Service is exposed to the internet via HTTPS only, ensuring secure public access. Internal API calls between the Frontend and Backend App Services occur within the subnet, never leaving the VNET for improved security and performance. 

- **Application Insights:** Both the Frontend and Backend App Services are integrated with Azure Application Insights for monitoring, logging, and diagnostics. This enables real-time visibility into application health, performance, and usage, and supports proactive alerting and troubleshooting.

- **Private Endpoint (PE) Subnets:**
  - **SQL Database:** The Backend App Service communicates with the SQL Database through a private endpoint in a dedicated PE subnet. This ensures that database traffic never traverses the public internet, reducing exposure and improving security.
  - **Blob Storage:** Similarly, Blob Storage is accessed via a private endpoint in its own PE subnet, allowing secure, private connectivity from the app services to storage resources.

- **Network Security:** By segmenting the network into subnets (Web, PE for SQL, PE for Storage), the design enforces least-privilege access and enables granular network security rules. Only necessary traffic is allowed between components, and all sensitive resources are shielded from direct internet exposure.

- **HTTPS-Only Access:** The architecture enforces HTTPS-only access from the internet to the Frontend App Service, protecting data in transit and meeting security best practices.

- **Scalability & Maintainability:** The modular approach (separate subnets, private endpoints, Application Insights integration, and clear separation of frontend, backend, database, and storage) allows for independent scaling, easier troubleshooting, and future extensibility.

This design ensures that all critical data flows (API calls, database access, storage access, and telemetry) remain private within Azure, while only the necessary entry point (Frontend App Service) is exposed to the public, and only over secure channels. Application Insights provides end-to-end observability for both frontend and backend services.

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

