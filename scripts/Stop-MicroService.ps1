#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Must be supplied. In the future we will support alternative switches.
    [Parameter(Mandatory=$true, ParameterSetName="k8s" )]
    [switch]
    $K8s,
    
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $ServiceName,

    [Parameter(Mandatory=$false)]
    [ValidateSet(
        "db",
        "api",
        "all"
    )]
    [string]
    $Part = "all",

    [Parameter(Mandatory=$false)]
    [bool]
    $NodePortOnly,

    [Parameter(Mandatory=$false)]
    [bool]
    $Cold
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

$servicename_lower = $ServiceName.ToLower()
$kubeconfig = "$ServicePath/kubernetes"

switch ($Part.ToLower()) {
    "db" {  
        if ($Cold) {
            . "$PSScriptRoot/Remove-MicroServicePart.ps1" -ServiceName $ServiceName -Part "volume" 
            . "$PSScriptRoot/Remove-MicroServicePart.ps1" -ServiceName $ServiceName -Part "configmap" 
        }

        if (-not $NodePortOnly) {
            kubectl delete -f $kubeconfig/$servicename_lower-db-statefulset.yaml

            kubectl delete pvc/data-$servicename_lower-db-0            
        }

        # Necessary if we are debugging an app running on our local machine. 
        kubectl delete -f "$kubeconfig/$servicename_lower-db-service-nodeport.yaml"
    }
    "api" {                
        if (-not $NodePortOnly) {
            kubectl delete -f "$kubeconfig/$servicename_lower-api-service-public.yaml"

            kubectl delete -f "$kubeconfig/$servicename_lower-api-service-replicaset.yaml"
        }

        # Necessary if we are debugging an app running on our local machine. 
        kubectl delete -f "$kubeconfig/$servicename_lower-api-service-nodeport.yaml"
    }
    "all" {
        . "$PSScriptRoot/Stop-MicroService.ps1" -ServiceName $ServiceName -Part "db" -NodePortOnly $NodePortOnly -Cold $Cold
        . "$PSScriptRoot/Stop-MicroService.ps1" -ServiceName $ServiceName -Part "api" -NodePortOnly $NodePortOnly -Cold $Cold
    }
    Default {
        Get-Help "$PSScriptRoot/Stop-MicroService.ps1" 
    }
}