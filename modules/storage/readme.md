# Storage Module

This module provisions Azure Storage resources.

## Inputs
See `variables.tf` for configurable parameters.

## Outputs
See `outputs.tf` for exported values.

## Usage Example
```hcl
module "storage" {
  source = "../modules/storage"
  # ...module variables...
}
```
