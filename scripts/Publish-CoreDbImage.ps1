#!/usr/bin/pwsh

Write-Host "Pulling the database image"
docker pull postgres:alpine

Write-Host "Tagging the database image"
docker tag postgres:alpine localhost:32000/postgres:alpine

Write-Host "Pushing the database image"
docker push localhost:32000/postgres:alpine





