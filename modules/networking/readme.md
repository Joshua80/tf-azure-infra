# Networking Module

This module provisions Azure networking resources (VNet, subnets, etc.).

## Inputs
See `variables.tf` for configurable parameters.

## Outputs
See `outputs.tf` for exported values.

## Usage Example
```hcl
module "networking" {
  source = "../modules/networking"
  # ...module variables...
}
```
