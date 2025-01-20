package test

import (
	"testing"
	"strings"
	
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestItApplies_Regression_Part_1(t *testing.T) {
	
	opts := GetTestConfig(t)

	terraformOptions := Setup(t, "examples/rg", opts)

	_, err := terraform.InitAndApplyE(t, terraformOptions)
	require.Nil(t, err)
}

func TestItApplies_Regression_Part_2(t *testing.T) {
	
	opts := GetTestConfig(t)

	terraformOptions := Setup(t, "examples/rg", opts)

	defer terraform.Destroy(t, terraformOptions)
	applyOutput, err := terraform.InitAndApplyE(t, terraformOptions)

	t.Log(applyOutput)

	// Check if apply output contains indications of resource changes
	noChanges := strings.Contains(applyOutput, "No changes.")
	completeZeroAddedChangedDestroyed := strings.Contains(applyOutput, "Apply complete! Resources: 0 added, 0 changed, 0 destroyed.")

	t.Log(noChanges)
	t.Log(completeZeroAddedChangedDestroyed)
	
	require.Nil(t, err)
	require.True(t, noChanges)
	require.True(t, completeZeroAddedChangedDestroyed)
}