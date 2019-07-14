#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "iam-id-mgmt",
        "router"
    )]
    [string]
    $ServiceName,
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "volume",
        "configmap"
    )]
    [string]
    $Part
)

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
$kubeconfig = $details["kubernetes"]

switch ($Part.ToLower()) {
    "volume" {  
            kubectl delete -f "$kubeconfig/$ServiceName-db-persistent-volume.yaml"
    }
    "configmap" {
            kubectl delete -f "$kubeconfig/$ServiceName-configmap.yaml"
    }
    "dbjob" {
        kubectl delete -f "$kubeconfig/$ServiceName-api-job-initialize-db.yaml"
    }
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroService.ps1" 
    }
}