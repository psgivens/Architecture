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
        "configmap",
        "dbjob"
    )]
    [string]
    $Part
)

$ServicePath = "$env:BESPIN_REPOS/$ServiceName"

if (-not (Test-Path $ServicePath)) {
    Write-Host "$servicePath not found"
    throw "$servicePath not found"
    exit
}

$lower = $ServiceName.ToLower()

# $details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
$kubeconfig = "$ServicePath/kubernetes"

switch ($Part.ToLower()) {
    "volume" {  
            kubectl create -f "$kubeconfig/$lower-db-persistent-volume.yaml"
    }
    "configmap" {
            kubectl create -f "$kubeconfig/$lower-configmap.yaml"
    }
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroService.ps1" 
    }
}