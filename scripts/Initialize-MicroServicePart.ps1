#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Parameter help description
    [Parameter(Mandatory = $true, ParameterSetName="kubernetes")]
    [string]
    $K8s,

    # Parameter help description
    [Parameter(Mandatory = $true)]
    [string]
    $ServiceName,
    [Parameter(Mandatory = $true)]
    [ValidateSet(
        "volume",
        "configmap",
        "dbjob"
    )]
    [string]
    $Part
)

if (-not $K8s) {
    Write-Host "Only -K8s is supported at this time"
    throw "Only -K8s is supported at this time"
    exit
}

$ServicePath = "$env:BESPIN_REPOS/$ServiceName"

if (-not (Test-Path $ServicePath)) {
    Write-Host "$servicePath not found"
    throw "$servicePath not found"
    exit
}

$lower = $ServiceName.ToLower()
$kubeconfig = "$ServicePath/kubernetes"

switch ($Part.ToLower()) {
    "volume" {  
        kubectl create -f "$kubeconfig/$lower-db-persistent-volume.yaml"
    }
    "configmap" {
        kubectl create -f "$kubeconfig/$lower-configmap.yaml"
    }
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroServicePart.ps1" 
    }
}