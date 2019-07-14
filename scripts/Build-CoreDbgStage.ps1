#!/usr/bin/pwsh

$buildpath = "$env:POMODORO_REPOS/Architecture"

Write-Host "Build dotnet stage image"
docker build `
    -t dotnet-stage `
    -f "$buildpath/tools/dotnet.stage.Dockerfile" `
    "$buildpath/tools"





