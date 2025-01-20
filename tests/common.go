package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

type Options map[string]any

func DefaultOptions() Options {
	return Options{
		"rg_name": "name",
		"location": "location",
		"tags": map[string]interface{}{
  			"key": "value",
		},
		"pol_description": "description",
		"pol_display_name": "display_name",
		"pol_name": "name",
		"pol_non_compliance_messages": []interface{}{
			map[string]interface{}{
				"message": "message",
				"policyDefinitionReferenceId": "id",
			},
		},
		"pol_parameters": map[string]map[string]interface{}{
			"parameter": {
				"key": "value",
			},			
		},
		"pol_scope": "resource_id", 
	}
}

func (o Options) With(with Options) Options {
	options := o
	for k, v := range with {
		options[k] = v
	}
	return options
}

func (o Options) Without(key string) Options {
	option := o
	delete(option, key)
	return option
}

func Setup(t *testing.T, e string, opts Options) *terraform.Options {
	return &terraform.Options{
		TerraformDir: fmt.Sprintf("../%s", e),
		Vars:         opts,
		BackendConfig: map[string]interface{}{
			"path": "test.tfstate",
		},
		Upgrade: true,
	}
}

func GetTestConfig(t *testing.T) Options {
	t.Helper()

	return Options{
		"rg_name": os.Getenv("RESOURCE_GROUP_NAME"),
		"location": os.Getenv("RESOURCE_GROUP_LOCATION"),
		"tags": map[string]interface{}{
  			"Terratest": "True",
			"Project": "Terratest",
		},
		"pol_description": "Enforces the requirement for a tag name of project on each resource group",
		"pol_display_name": "Require Project Tag on Resource Groups",
		"pol_name": "Check for project tag on resource groups",
		"pol_non_compliance_messages": []interface{}{
			map[string]interface{}{
				"message": "The Resource Group must have a Project Tag!",
				"policyDefinitionReferenceId": "/providers/Microsoft.Authorization/policyDefinitions/d8cf8476-a2ec-4916-896e-992351803c44",
			},
		},
		"pol_parameters": map[string]interface{}{
			"tagName": map[string]interface{} {
				"value": "Project",
			  },
		},
		"pol_scope": os.Getenv("ARM_SUBSCRIPTION_ID"),
	}
}
