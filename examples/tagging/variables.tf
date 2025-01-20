variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9._()\\-]*[^.]$", var.rg_name))
    error_message = "The resource group name must start with a number or letter, and can consist of letters, numbers, underscores, periods, parentheses and hyphens but must not end in a period."
  }
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  validation {
    condition     = can(regex("^[a-z]+(?:[23])?$", var.location))
    error_message = "The location must be a lowercase and constructed using letters a-z; can have an optional number appended too."
  }
}

variable "tags" {
  description = "A map of tags"
  type        = map(any)
  default     = {}
  validation {
    condition     = alltrue([for v in values(var.tags) : can(regex(".*", v))])
    error_message = "All values in the map must be strings"
  }
}

variable "pol_description" {
  description = "The Azure Policy description"
  default     = null
  type        = string
  validation {
    condition     = var.pol_description == null || length(var.pol_description) > 0
    error_message = "If you're providing a value, it must not be an empty string"
  }
}

variable "pol_display_name" {
  description = "The Azure Policy display name"
  default     = null
  type        = string
  validation {
    condition     = var.pol_display_name == null || length(var.pol_display_name) > 0
    error_message = "If you're providing a value, it must not be an empty string"
  }
}

variable "pol_non_compliance_messages" {
  description = "A list of objects which contain a non compliance message, and an optional definition reference id"
  type = list(object({
    message                     = string
    policyDefinitionReferenceId = optional(string)
  }))
}

variable "pol_name" {
  description = "The name of the resource group"
  type        = string
  validation {
    condition     = can(regex("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$", var.pol_name))
    error_message = "The Policy name must not use the control characters #<>%&:\\?/ or end with a space or period character."
  }
}

variable "pol_parameters" {
  description = "A map of parameters for this policy"
  default     = null
  type        = map(any)
}

variable "pol_scope" {
  description = "The scope of the policy assignment i.e. the management group, subscription or resource group resource id."
  type        = string
  validation {
    condition     = can(regex("^/providers/Microsoft.Management/managementGroups/[a-zA-Z0-9][a-zA-Z0-9._()\\-]*$") || regex("^/subscriptions/[0-9a-fA-F-]+$") || regex("^/subscriptions/[0-9a-fA-F-]+/resourceGroups/[a-zA-Z0-9][a-zA-Z0-9._()\\-]*[^.]$", var.pol_scope))
    error_message = "The resource id must be a management group, subscription, or resource group resource id."
  }
}