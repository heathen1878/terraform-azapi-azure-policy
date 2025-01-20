package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

// func TestItErrorsWhenNameIsEmpty(t *testing.T) {

// }

func TestItErrorsWhenLocationIsEmpty(t *testing.T) {
	//t.Parallel()

	opts := DefaultOptions().Without("location")

	terraformOptions := Setup(t, "examples/tagging", opts)

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	require.NotNil(t, err)
}

func TestItErrorsWhenNameIsEmpty(t *testing.T) {
	//t.Parallel()

	opts := DefaultOptions().Without("name")

	terraformOptions := Setup(t, "examples/tagging", opts)

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	require.NotNil(t, err)
}

func TestItApplies(t *testing.T) {
	//t.Parallel()

	opts := GetTestConfig(t)

	terraformOptions := Setup(t, "examples/tagging", opts)

	defer terraform.Destroy(t, terraformOptions)
	_, err := terraform.InitAndApplyE(t, terraformOptions)

	resource_group := map[string]any{}
	terraform.OutputStruct(t, terraformOptions, "resource_group", &resource_group)

	t.Log(resource_group["resource_group"].(map[string]any)["id"])
	t.Log(resource_group["resource_group"].(map[string]any)["name"])
	t.Log(resource_group["resource_group"].(map[string]any)["location"])
	t.Log(resource_group["resource_group"].(map[string]any)["tags"])
	t.Log(opts["name"])
	t.Log(opts["location"])
	t.Log(opts["tags"])

	require.Nil(t, err)
	require.Equal(t, opts["name"], resource_group["resource_group"].(map[string]any)["name"])
	require.Equal(t, opts["location"], resource_group["resource_group"].(map[string]any)["location"])
	require.Equal(t, opts["tags"], resource_group["resource_group"].(map[string]any)["tags"])
}