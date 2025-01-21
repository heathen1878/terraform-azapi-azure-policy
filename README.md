# Azure Policy Module

## Tests

[![Terratest](https://github.com/heathen1878/terraform-azapi-azure-policy/actions/workflows/module_tests.yaml/badge.svg)](https://github.com/heathen1878/terraform-azapi-azure-policy/actions/workflows/module_tests.yaml)

## Security

[![Dependabot](https://img.shields.io/badge/dependabot-active-brightgreen?style=flat-square&logo=dependabot)](https://github.com/heathen1878/terraform-azapi-azure-policy/security/dependabot)

## Examples

[Tagging on Resource Groups](examples/tagging/README.md)

## Usage

```go
# Typically nested within another module to manage Azure Policy Assignments
module "AzPol" {

    source ="heathen1878/azure-policy/azapi"
    version = "1.0.0"

    # Five mandatory parameters

}

```

## Version 1.0.0

- Supports AzApi 1.14.0 up to AzApi 2.2.0
- Supports Terraform core executable 1.*
- Creates Azure Policies assignments; tends to be nested within other modules
