#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    # [ValidateSet(
    #     "iam-id-mgmt",
    #     "router"
    # )]
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

# $details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
# $kubeconfig = $details["kubernetes"]

$ServicePath = "$env:BESPIN_REPOS/$ServiceName"

if (-not (Test-Path $ServicePath)) {
    Write-Host "$servicePath not found"
    throw "$servicePath not found"
    exit
}


$servicename_lower = $ServiceName.ToLower()
$kubeconfig = "$ServicePath/kubernetes"

switch ($Part.ToLower()) {
    "volume" {  
            kubectl delete -f "$kubeconfig/$servicename_lower-db-persistent-volume.yaml"
    }
    "configmap" {
            kubectl delete -f "$kubeconfig/$servicename_lower-configmap.yaml"
    }
    "dbjob" {
        kubectl delete -f "$kubeconfig/$servicename_lower-api-job-initialize-db.yaml"
    }
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroService.ps1" 
    }
}