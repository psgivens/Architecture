#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "iam-id-mgmt"
    )]
    [string]
    $ServiceName,
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "initialize-db",
        "integration-tests"
    )]
    [string]
    $Job
)

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
$kubeconfig = $details["kubernetes"]

switch ($Job.ToLower()) {
    "initialize-db" {
        Write-Host "Delete the initialization job 'dotnet ef database update'"
        kubectl delete -f "$kubeconfig/$ServiceName-job-initialize-db.yaml"
    }
    
    "integration-tests" {
        Write-Host "Delete the integration tests job"
        kubectl delete -f "$kubeconfig/$ServiceName-job-integration-tests.yaml"
    }
    
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroService.ps1" 
    }
}