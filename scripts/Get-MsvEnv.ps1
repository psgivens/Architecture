#!/usr/bin/pwsh

param (
    # Parameter help description
    [Parameter(Mandatory=$false)]
    [ValidateSet(
      "ServiceName"
    )]
    $Name,
    # Parameter help description
    [Parameter(Mandatory=$false)]
    [Switch]
    $UseDefaults    
)

$envdir = "/tmp/actionable"
$envpath = "$envdir/pomenv.json"

if (Test-Path $envpath) { 
  $environment = Import-Clixml -Path $envpath 
} 

if ($Name) { $environment[$Name] }
else { $environment }



