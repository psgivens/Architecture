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
    [Parameter(Mandatory=$false)]
    [bool]
    $Cold
)

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
$kubeconfig = $details["kubernetes"]

Start-MicroService.ps1 -ServiceName "iam-id-mgmt" -Part "all" -Cold $Cold

Write-Host "Waiting for api service to come online."

$retries=70
foreach ($i in 1..$retries) {
    $cmd = "kubectl get pods -o json -l app=$ServiceName-api-service"
    $phase = Invoke-Expression $cmd | ConvertFrom-Json | ForEach-Object {$_.items.status.containerStatuses.ready}
    Write-Host "Ready: $phase"
    if ($phase -eq 'True') { 
        Write-Host "API Service is running."
        break 
    }
    if ($i -eq $retries) { 
        Write-Host "Match not found after $retries retries"
        exit
    }
    Start-Sleep 1
}

Write-Host "Run a job with the integration tests"
Start-MicroServiceJob.ps1 -ServiceName "iam-id-mgmt" -Job "integration-tests"

Write-Host "Waiting 10 seconds for integration test job to start."
Start-Sleep 10 
kubectl log --selector=app=$ServiceName-api-job-integration-tests -f

Stop-MicroServiceJob.ps1 -ServiceName "iam-id-mgmt" -Job "integration-tests"

Stop-MicroService.ps1 -ServiceName "iam-id-mgmt" -Part "all" -Cold $Cold

