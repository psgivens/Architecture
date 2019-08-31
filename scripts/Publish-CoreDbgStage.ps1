#!/usr/bin/pwsh

$image = "localhost:32000/dotnet-stage"

& $PSScriptRoot/Build-CoreDbgStage.ps1

docker push $image




