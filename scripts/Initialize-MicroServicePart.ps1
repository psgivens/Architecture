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

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
$kubeconfig = $details["kubernetes"]

switch ($Part.ToLower()) {
    "volume" {  
            kubectl create -f "$kubeconfig/$ServiceName-db-persistent-volume.yaml"
    }
    "configmap" {
            kubectl create -f "$kubeconfig/$ServiceName-configmap.yaml"
    }
    Default {
        Get-Help "$PSScriptRoot/Initialize-MicroService.ps1" 
    }
}