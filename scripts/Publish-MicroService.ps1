#!/usr/bin/pwsh
param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "iam-id-mgmt"
    )]
    [string]
    $ServiceName
)

& "$PSScriptRoot/Build-MicroService.ps1" -ServiceName $ServiceName

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

$ImageName = $details["imagename"]

$image = "localhost:32000/$ServiceName-$ImageName"

docker push $image

