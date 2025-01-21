variable "assignment_type" {
  description = "The type of policy assignment; defaults to custom."
  default     = "Custom"
  type        = string
  validation {
    condition = contains(
      [
        "Custom",
        "NotSpecified",
        "System",
        "SystemHidden"
      ], var.assignment_type
    )
    error_message = "The assignment type must be on of Custom, NotSpecified, System, or SystemHidden."
  }
}

variable "definition_version" {
  description = "The version of this definition policy to use"
  type        = string
}

variable "description" {
  description = "The Azure Policy description"
  default     = null
  type        = string
  validation {
    condition     = var.description == null || length(var.description) > 0
    error_message = "If you're providing a value, it must not be an empty string"
  }
}

variable "display_name" {
  description = "The Azure Policy display name"
  default     = null
  type        = string
  validation {
    condition     = var.description == null || length(var.display_name) > 0
    error_message = "If you're providing a value, it must not be an empty string"
  }
}

variable "enforce" {
  description = "Should the policy be enforced?"
  default     = "Default"
  type        = string
  validation {
    condition = contains(
      [
        "Default",
        "DoNotEnforce",
        "Enroll"
      ], var.enforce
    )
    error_message = "The enforcement must be either Default, DoNotEnforce, or Enroll."
  }
}

variable "identity" {
  description = "An identity object"
  default = {
    type = "None"
  }
  type = object({
    type = string
  })
}

variable "location" {
  description = "The Azure Region where the policy should reside; defaults to uksouth."
  default     = "uksouth"
  type        = string
  validation {
    condition     = can(regex("^[a-z]+(?:[23])?$", var.location))
    error_message = "The location must be a lowercase and constructed using letters a-z; can have an optional number appended too."
  }
}

variable "metadata" {
  description = "A collection of key value pairs"
  default     = {}
  type        = map(any)
}

variable "name" {
  description = "The Azure Policy Name"
  type        = string
  validation {
    condition     = can(regex("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$", var.name))
    error_message = "The Name variable must match the regex pattern ^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  }
}

variable "non_compliance_messages" {
  description = "A list of objects which contain a non compliance message, and an optional definition reference id"
  type = list(object({
    message                     = string
    policyDefinitionReferenceId = optional(string)
  }))
}

variable "not_scopes" {
  description = "A list of scopes to be excluded from this policy"
  default     = []
  type        = list(string)
}

variable "overrides" {
  description = "A list of policy overrides"
  default     = []
  type = list(object(
    {
      kind = string
      selectors = optional(list(object(
        {
          in    = optional(list(string))
          kind  = optional(string)
          notIn = optional(list(string))
        }
      )), [])
      value = optional(string)
    }
  ))
}

variable "parameters" {
  description = "A map of parameters for this policy"
  default     = null
  type        = map(any)
}

variable "policy_definition_id" {
  description = "The policy definition id being assigned; these can be found within Azure Policy definitions."
  type        = string
  validation {
    condition     = can(regex("^/providers/Microsoft.Authorization/policyDefinitions/[0-9a-fA-F-]+$", var.policy_definition_id))
    error_message = "The policy definition Id must be valid."
  }
}

variable "resource_selectors" {
  description = "A list of resource selectors; used to filter"
  default     = []
  type = list(object(
    {
      name = string
      selectors = optional(list(object(
        {
          in    = optional(list(string))
          kind  = optional(string)
          notin = optional(list(string))
        }
      )), [])
    }
  ))
}

variable "scope" {
  description = "The scope of the policy assignment i.e. the management group, subscription or resource group resource id."
  type        = string
  validation {
    condition     = can(regex("^/providers/Microsoft.Management/managementGroups/[a-zA-Z0-9][a-zA-Z0-9._()\\-]*$|^/subscriptions/[0-9a-fA-F-]+$|^/subscriptions/[0-9a-fA-F-]/resourceGroups/[a-zA-Z0-9][a-zA-Z0-9._()\\-]*[^.]$", var.scope))
    error_message = "The resource id must be a management group, subscription, or resource group resource id."
  }
}

