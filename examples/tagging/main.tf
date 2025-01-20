locals {
    location = "uksouth"
}

module "rg" {

  source  = "heathen1878/resource-groups/azurerm"
  version = "4.0.0"

  name = "rg-azure-policy-example"
  location = local.location
  tags = {

  }
}

module "azpol" {

    source = "../.."

    description = "Enforces the requirement for a tag name of project on each resource group"
    display_name = "Require Project Tag on Resource Groups"
    identity = {}
    location = local.location
    name = "Check for project tag on resource groups"
    non_compliance_messages = [
        {
            message = "The Resource Group must have a Project Tag!"
            policyDefinitionReferenceId = data.azurerm_policy_definition.require_a_tag_on_resource_groups.id
        }
    ]
    parameters = {
      tagName = {
        value = "Project"
      }
    }
    policy_definition_id = data.azurerm_policy_definition.require_a_tag_on_resource_groups.id
    scope = module.rg.resource_group.id
}