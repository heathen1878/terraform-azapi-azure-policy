# Azure Policy Project Tag on Resource Group module

[Home](../../README.md)

This example is used by Terraform to validate the actual module. 

__NOTE__ 

The provider version is intentionally not defined; this allows the tests to dynamically change the provider version as needed. For example...

```shell
sed -i "5aversion = \"${CURRENT_VERSION}\"" examples/tagging/versions.tf
terraform fmt examples/tagging
```

