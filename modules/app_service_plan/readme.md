# App Service Plan Module

This module provisions an Azure App Service Plan.

## Inputs
See `variables.tf` for configurable parameters.

## Outputs
See `outputs.tf` for exported values.

## Usage Example
```hcl
module "app_service_plan" {
  source = "../modules/app_service_plan"
  # ...module variables...
}
```
