#!/usr/bin/pwsh

$buildpath = "$env:POMODORO_REPOS/Architecture"

$image = "localhost:32000/dotnet-stage"

Write-Host "Build dotnet stage image"
docker build `
    -t dotnet-stage `
    -t $image `
    -f "$buildpath/tools/dotnet.stage.Dockerfile" `
    "$buildpath/tools"





