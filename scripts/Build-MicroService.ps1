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

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

$Context = if ($details["context"]) {
  $details["context"] 
} else {
  $env:POMODORO_REPOS
}

$DockerFile = if ($details["dockerfile"]) {
  $details["dockerfile"] 
} else {
  $Context, "Dockerfile" -join "/"
}

$ImageName = $details["imagename"]

$image = "localhost:32000/$ServiceName-$ImageName"

docker build `
  -t $image `
  -f $DockerFile `
  $Context


