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
    $ServiceName
)

switch ($ServiceName) {
    "iam-id-mgmt" {
        $location="$env:POMODORO_REPOS/IdentityManagement"
        @{
            "root" = $location
            "scripts" = "$location/scripts"
            "kubernetes" = "$location/kubernetes"
            "context" = "$location/.."
            "dockerfile" = "$location/watch.Dockerfile"
            "imagename" = "api-service"
        }    
    }
    "router" {
        $location="$env:POMODORO_REPOS/Architecture/Router"
        @{
            "root" = $location
            "scripts" = "$location/scripts"
            "kubernetes" = "$location/kubernetes"
            "context" = "$location/image"
            "dockerfile" = "$location/Dockerfile"
            "imagename" = "reverse-proxy"
        }    
    }
    Default {
        Get-Help "$PSScriptPath/Start-MicroService.ps1" 
    }
}