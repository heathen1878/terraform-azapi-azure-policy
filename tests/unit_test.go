package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestItErrorsWhenPolicyNameIsEmpty(t *testing.T) {
	t.Parallel()

	opts := DefaultOptions().Without("pol_name")

	terraformOptions := Setup(t, "examples/tagging", opts)

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	require.NotNil(t, err)
}

func TestItErrorsWhenNonComplianceMessagesIsEmpty(t *testing.T) {
	t.Parallel()

	opts := DefaultOptions().Without("pol_non_compliance_messages")

	terraformOptions := Setup(t, "examples/tagging", opts)

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	require.NotNil(t, err)
}

func TestItErrorsWhenPolicyDefinitionIdIsEmpty(t *testing.T) {
	t.Parallel()

	opts := DefaultOptions().Without("name")

	terraformOptions := Setup(t, "examples/tagging", opts)

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	require.NotNil(t, err)
}

func TestItApplies(t *testing.T) {

	opts := GetTestConfig(t)

	terraformOptions := Setup(t, "examples/tagging", opts)

	defer terraform.Destroy(t, terraformOptions)
	_, err := terraform.InitAndApplyE(t, terraformOptions)

	policy := map[string]any{}
	terraform.OutputStruct(t, terraformOptions, "policy", &policy)

	t.Log(policy["policy"].(map[string]any)["id"])
	t.Log(opts["pol_non_compliance_messages"])

	require.Nil(t, err)
	require.Equal(t, opts["pol_scope"], policy["policy"].(map[string]any)["parent_id"])
	require.Equal(t, opts["pol_name"], policy["policy"].(map[string]any)["name"])
	//require.Equal(t, opts[""], resource_group["resource_group"].(map[string]any)["tags"])
}