# App Service Module

This module provisions an Azure App Service.

## Inputs
See `variables.tf` for configurable parameters.

## Outputs
See `outputs.tf` for exported values.

## Usage Example
```hcl
module "app_service" {
  source = "../modules/app_service"
  # ...module variables...
}
```
