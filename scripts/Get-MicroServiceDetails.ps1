#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Parameter help description
    [Parameter(
        Mandatory=$true,
        ParameterSetName="Service")]
    [string]
    $ServiceName,

    # Parameter help description
    [Parameter(
        Mandatory=$true,
        ParameterSetName="List")]
    [switch]
    $List    
)

if ($ServiceName) {
    $file = "$env:BESPIN_REPOS/$ServiceName/microserviceinfo.json"
    if (Test-Path $file) {
        $info = Get-Content $file | ConvertFrom-Json
        $info
    } else {
        throw "file not found: $file"
    }
    # switch ($ServiceName) {
    #     "iam-id-mgmt" {
    #         $location="$env:BESPIN_REPOS/IdentityManagement"
    #         @{
    #             "root" = $location
    #             "scripts" = "$location/scripts"
    #             "kubernetes" = "$location/kubernetes"
    #             "context" = "$location/.."
    #             "dockerfile" = "$location/watch.Dockerfile"
    #             "imagename" = "api-service"
    #         }    
    #     }
    #     "router" {
    #         $location="$env:BESPIN_REPOS/Architecture/Router"
    #         @{
    #             "root" = $location
    #             "scripts" = "$location/scripts"
    #             "kubernetes" = "$location/kubernetes"
    #             "context" = "$location/image"
    #             "dockerfile" = "$location/Dockerfile"
    #             "imagename" = "reverse-proxy"
    #         }    
    #     }
    #     Default {
    #         Get-Help "$PSScriptPath/Start-MicroService.ps1" 
    #     }
    # }
} else {
    pushd $env:BESPIN_REPOS
    ls -d * |? { Test-Path "$_/microserviceinfo.json" } 
    popd
}