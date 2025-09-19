# Key Vault Module

This module provisions an Azure Key Vault.

## Inputs
See `variable.tf` for configurable parameters.

## Outputs
See `output.tf` for exported values.

## Usage Example
```hcl
module "key_vault" {
  source = "../modules/key_vault"
  # ...module variables...
}
```
