package Test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func Challenge_For_Interview(t *testing.T) {
	// Run this Test in parallel
	t.Parallel()

	// Select a random AWS region to Test in. To ensure our code works in all regions.
	// awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	// *** This setting is for related to variables.tf ***
	awsRegion := "us-east-1"
	expectedNameTag := "Flugel"
	expectedOwnerTag := "InfraTeam"
	flugelBucket := "Challenge_for_Interview_Bucket"
	// ***

	terraformOptions := &terraform.Options{
		// Path to where our Terraform code is located
		TerraformDir: "../",

		// Execute this Test in a random AWS region
		// Environment variables to set when running Terraform
		// EnvVars: map[string]string{
		// 	"AWS_DEFAULT_REGION": awsRegion,
		// },
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// EC2 Instance Test
	instanceID := terraform.Output(t, terraformOptions, "Challenge_for_Interview_Instance_ID")

	// Get all the Tags from the created instance
	instanceTags := aws.GetTagsForEc2Instance(t, awsRegion, instanceID)

	// Verify our expected tags Name, Owner are equal to the expected ones
	nameTag, containsNameTag := instanceTags["Name"]
	assert.True(t, containsNameTag)
	assert.Equal(t, expectedNameTag, nameTag)

	ownerTag, containsOwnerTag := instanceTags["Owner"]
	assert.True(t, containsOwnerTag)
	assert.Equal(t, expectedOwnerTag, ownerTag)

	// S3 Bucket Tests
	bucketFound := aws.FindS3BucketWithTag(t, awsRegion, "Name", expectedNameTag)
	assert.Equal(t, flugelBucket, bucketFound)

	bucketFound = aws.FindS3BucketWithTag(t, awsRegion, "Owner", expectedOwnerTag)
	assert.Equal(t, flugelBucket, bucketFound)
}
