#!/usr/bin/pwsh
param (
    [Parameter(Mandatory=$true,
    ParameterSetName="compose"
    )]
    [switch]
    $Compose,
    
    # Parameter help description
    [Parameter(Mandatory=$true,
    ParameterSetName="k8s"
    )]
    [switch]
    $K8s,

    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $ServiceName
)

#$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

if ($Compose) {

    Push-Location "$env:BESPIN_REPOS/$ServiceName/compose"
    docker-compose -f docker-compose-init.yml --renew-anon-volumes up
    Pop-Location

} elseif ($K8s) {
    Write-Host "Initialize kubernetes not implemented"
    throw "Initialize kubernetes not implemented"
}





