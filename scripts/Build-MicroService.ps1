#!/usr/bin/pwsh
param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $ServiceName
)

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

$Context = if ($details.context) {
  "$env:BESPIN_REPOS/$($details.context)"
} else {
  $env:BESPIN_REPOS
}

Write-Host ("context: $Context")

$DockerFile = if ($details.dockerfile) {
  $Context, $details.dockerfile -join "/"

} else {
  $Context, "Dockerfile" -join "/"
}

Write-Host ("Dockerfile: $DockerFile")

$ImageName = $details.imagesuffix
$lower = $ServiceName.ToLower()

$image = "$lower-$ImageName"
$image_remote = "localhost:32000/$lower-$ImageName"

docker build `
  -t $image `
  -t $image_remote `
  -f $DockerFile `
  $Context


