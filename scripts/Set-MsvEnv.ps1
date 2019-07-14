#!/usr/bin/pwsh

param (
    # Parameter help description
    [Parameter(Mandatory=$false)]
    [ValidateSet(
        "iam-id-mgmt"
      )]  
    [String]
    $ServiceName
)

$envdir = "/tmp/actionable"
$envpath = "$envdir/pomenv.json"

if (Test-Path $envpath) { 
  $environment = Import-Clixml -Path $envpath 
} else { $environment = @{} }

Write-Host "Previous environment"
$environment | Format-Table

if ($ServiceName) {
  $environment["ServiceName"] = $ServiceName
}

Write-Host "New environment"
$environment | Format-Table

mkdir -p $envdir 
$environment | Export-Clixml -Path $envpath


