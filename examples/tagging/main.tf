module "azpol" {

  source = "../.."

  description             = var.pol_description
  display_name            = var.pol_display_name
  location                = var.location
  name                    = var.pol_name
  non_compliance_messages = var.pol_non_compliance_messages
  parameters = {
    tagName = {
      value = "Project"
    }
  }
  policy_definition_id = data.azurerm_policy_definition.require_a_tag_on_resource_groups.id
  scope                = var.pol_scope
}


module "rg" {

  source  = "heathen1878/resource-groups/azurerm"
  version = "4.0.0"

  name     = var.rg_name
  location = var.location
  tags     = var.tags

  depends_on = [
    data.azurerm_policy_definition.require_a_tag_on_resource_groups
  ]
}

