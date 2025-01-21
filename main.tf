resource "azapi_resource" "policy_assignment" {
  type      = "Microsoft.Authorization/policyAssignments@2024-04-01"
  name      = var.name
  parent_id = var.scope
  identity {
    type = var.identity.type
  }
  location = var.location
  body = {
    properties = {
      assignmentType        = var.assignment_type
      definitionVersion     = var.definition_version
      description           = var.description
      displayName           = var.display_name
      enforcementMode       = var.enforce
      metadata              = var.metadata
      nonComplianceMessages = var.non_compliance_messages
      notScopes             = var.not_scopes
      overrides             = var.overrides
      parameters            = var.parameters
      policyDefinitionId    = var.policy_definition_id
      resourceSelectors     = var.resource_selectors
    }
  }
}