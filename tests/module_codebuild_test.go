package test

import (
	"encoding/json"
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/codebuild"
	"github.com/aws/aws-sdk-go/service/codepipeline"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"os"
	"path/filepath"
	"testing"
	"time"
)

const (
	base             = "../examples/"
	testVarFileName  = "/test.tfvars"
	pipelineWaitTime = 30
)

type TestTfvars struct {
	CodebuildProjects []struct {
		Name         string              `json:"name"`
		Buildspec    string              `json:"buildspec"`
		CodebuildIAM map[string][]string `json:"codebuild_iam"`
	} `json:"codebuild_projects"`
}

func loadTfVars(t *testing.T, dir string, testFile string) TestTfvars {
	const (
		//to store tfvars
		tmp_json_filename = ".ignore_me.json"
	)
	jsonOutPath := filepath.Join(dir, tmp_json_filename)
	err := terraform.HCLFileToJSONFile(filepath.Join(dir, testFile), jsonOutPath)
	defer func() {
		os.Remove(tmp_json_filename)
	}()
	assert.NoError(t, err)
	var vars TestTfvars
	bytes, err := os.ReadFile(jsonOutPath)
	assert.NoError(t, err)
	err = json.Unmarshal(bytes, &vars)
	assert.NoError(t, err)
	return vars
}

func TestCodeBuild(t *testing.T) {
	t.Parallel()
	stage := test_structure.RunTestStage

	files, err := os.ReadDir(base)
	assert.NoError(t, err)
	basePath, _ := filepath.Abs(base)
	for _, file := range files {
		dir := filepath.Join(basePath, file.Name())
		if file.IsDir() {
			defer stage(t, "teardown_codebuild", func() { tearDownCodeBuild(t, dir) })
			stage(t, "setup_codebuild", func() { setupCodeBuildTest(t, dir) })
			stage(t, "test_codebuild", func() { testCodeBuild(t, dir) })
		}
	}
}

func setupCodeBuildTest(t *testing.T, dir string) {

	terraformOptions := &terraform.Options{
		TerraformDir: dir,
		VarFiles:     []string{dir + testVarFileName},
		NoColor:      true,
		Logger:       logger.Discard,
	}

	test_structure.SaveTerraformOptions(t, dir, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

}

func testCodeBuild(t *testing.T, dir string) {
	terraformOptions := test_structure.LoadTerraformOptions(t, dir)
	terraformOptions.Logger = logger.Discard

	sess, err := session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	})
	assert.NoError(t, err, "can't connect to aws")
	client := codebuild.New(sess)
	tfvars := loadTfVars(t, dir, testVarFileName)
	result, err := client.ListProjects(
		&codebuild.ListProjectsInput{})
	assert.NoError(t, err)
	actualProjects := make([]string, len(result.Projects))
	for i, p := range result.Projects {
		actualProjects[i] = *p
	}
	naming_prefix := terraform.Output(t, terraformOptions, "naming_prefix")
	region := terraform.Output(t, terraformOptions, "region")
	environment := terraform.Output(t, terraformOptions, "environment")
	environment_number := terraform.Output(t, terraformOptions, "environment_number")
	resource_name := terraform.Output(t, terraformOptions, "resource_name")
	resource_number := terraform.Output(t, terraformOptions, "resource_number")
	for _, expectedProjectName := range tfvars.CodebuildProjects {
		name := naming_prefix + "_" + expectedProjectName.Name + "-" + region + "-" + environment + "-" + environment_number + "-" + resource_name + "-" + resource_number
		assert.Contains(t, actualProjects, name)
	}
	pipelineClient := codepipeline.New(sess)
	codepipelineId := terraform.Output(t, terraformOptions, "codepipeline_name")
	checkCodePipeline(t, codepipelineId, pipelineClient)
}

func checkCodePipeline(t *testing.T, codepipelineId string, client *codepipeline.CodePipeline) {

	// Pipeline states
	keepRunning := true
	for {
		if keepRunning == false {
			break
		}
		keepRunning = false
		input := &codepipeline.GetPipelineStateInput{
			Name: aws.String(codepipelineId),
		}
		result, err := client.GetPipelineState(input)
		if err != nil {
			assert.Error(t, err, "The expected pipeline state was not found")
		}
		for _, stage := range result.StageStates {
			currentStatus := stage.LatestExecution.Status // "Succeeded/InProgress/Failed"
			if *currentStatus == "InProgress" {
				keepRunning = true
				logger.Log(t, fmt.Sprintf("waiting for InProgress pipeline %s %s stage to complete", codepipelineId, *stage.StageName))
				time.Sleep(pipelineWaitTime * time.Second) //sleep 3min
				break
			}
			assert.Equal(t, *currentStatus, "Succeeded")

		}
	}
}

func tearDownCodeBuild(t *testing.T, dir string) {
	terraformOptions := test_structure.LoadTerraformOptions(t, dir)
	terraformOptions.Logger = logger.Discard
	terraform.Destroy(t, terraformOptions)
}
