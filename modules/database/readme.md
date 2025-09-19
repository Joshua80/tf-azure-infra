# Database Module

This module provisions Azure database resources (e.g., SQL, PostgreSQL).

## Inputs
See `variables.tf` for configurable parameters.

## Outputs
See `outputs.tf` for exported values.

## Usage Example
```hcl
module "database" {
  source = "../modules/database"
  # ...module variables...
}
```
