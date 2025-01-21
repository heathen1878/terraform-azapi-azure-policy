module "azpol" {

  source = "../.."

  definition_version      = var.pol_definition_version
  description             = var.pol_description
  display_name            = var.pol_display_name
  location                = var.location
  name                    = var.pol_name
  non_compliance_messages = var.pol_non_compliance_messages
  parameters              = var.pol_parameters
  policy_definition_id    = var.pol_policy_definition_id
  scope                   = var.pol_scope
}


module "rg" {

  source  = "heathen1878/resource-groups/azurerm"
  version = "4.0.0"

  name     = var.rg_name
  location = var.location
  tags     = var.tags

  depends_on = [
    module.azpol
  ]
}

