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

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName
$kubeconfig = $details["kubernetes"]

switch ($Part.ToLower()) {
    "db" {  
        if ($Cold) {
            . "$PSScriptRoot/Remove-MicroServicePart.ps1" -ServiceName $ServiceName -Part "volume" 
            . "$PSScriptRoot/Remove-MicroServicePart.ps1" -ServiceName $ServiceName -Part "configmap" 
        }

        if (-not $NodePortOnly) {
            kubectl delete -f $kubeconfig/$ServiceName-db-statefulset.yaml

            kubectl delete pvc/data-$ServiceName-db-0
            
            kubectl delete -f $kubeconfig/$ServiceName-db-persistent-volume-pgsql.yaml
            
            kubectl delete -f $kubeconfig/$ServiceName-api-configmap.yaml        
        }

        # Necessary if we are debugging an app running on our local machine. 
        kubectl delete -f "$kubeconfig/$ServiceName-db-service-nodeport.yaml"
    }
    "api" {                
        if (-not $NodePortOnly) {
            kubectl delete -f "$kubeconfig/$ServiceName-api-service-public.yaml"

            kubectl delete -f "$kubeconfig/$ServiceName-api-service-replicaset.yaml"
        }

        # Necessary if we are debugging an app running on our local machine. 
        kubectl delete -f "$kubeconfig/$ServiceName-api-service-nodeport.yaml"
    }
    "all" {
        . "$PSScriptRoot/Stop-MicroService.ps1" -ServiceName $ServiceName -Part "db" -NodePortOnly $NodePortOnly 
        . "$PSScriptRoot/Stop-MicroService.ps1" -ServiceName $ServiceName -Part "api" -NodePortOnly $NodePortOnly 
    }
    Default {
        Get-Help "$PSScriptRoot/Stop-MicroService.ps1" 
    }
}