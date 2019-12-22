#!/usr/bin/pwsh
param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $ServiceName
)

& "$PSScriptRoot/Build-MicroService.ps1" -ServiceName $ServiceName

# TODO: Verify that the build succeded

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

$ImageName = $details.imagesuffix
$lower = $ServiceName.ToLower()

$image = "localhost:32000/$lower-$ImageName"

docker push $image

Write-Host "Did the build succeed?"