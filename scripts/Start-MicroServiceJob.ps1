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
        Write-Host "Initializing the database with 'dotnet ef database update'"
        kubectl create -f "$kubeconfig/$ServiceName-job-initialize-db.yaml"

        Write-Host "Wait for database initialization job to finish..."
        $retries=40
        foreach ($i in 1..$retries) {
            $cmd = "kubectl get pods -o json -l app=$ServiceName-job-initialize-db"
            $items = Invoke-Expression $cmd | ConvertFrom-Json | Foreach-Object { $_.items }
            if ($items.Count -lt 1) {
                Write-Host "No running pods found!"
            }
            $phase = $items | Foreach-Object { $_.status.phase } | Select-Object -First 1
            Write-Host "phase: $phase"
            if ($phase -eq "Succeeded") { 
                kubectl log --selector=app=$ServiceName-job-initialize-db -f
                Write-Host "Deleting job"
                kubectl delete -f $kubeconfig/$ServiceName-job-initialize-db.yaml
                break; }
            if ($i -eq $retries) { 
                Write-Host "Match not found after $retries retries"
                exit }
            Start-Sleep 5
        }    
    }
    
    "integration-tests" {
        Write-Host "Run a job with the integration tests"
        kubectl create -f "$kubeconfig/$ServiceName-job-integration-tests.yaml"
    }
    
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroService.ps1" 
    }
}