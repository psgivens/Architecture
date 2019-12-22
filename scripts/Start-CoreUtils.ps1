#!/usr/bin/pwsh

param (
    # Parameter help description
    [Parameter(Mandatory = $true,
        ParameterSetName = "docker"
    )]
    [switch]
    $Docker,

    # Parameter help description
    [Parameter(Mandatory = $true,
        ParameterSetName = "docker"
    )]
    [string]
    $Network,
    
    # Parameter help description
    [Parameter(Mandatory = $true,
        ParameterSetName = "k8s"
    )]
    [switch]
    $K8s        
)

if ($K8s) {    
    Write-Host "Runing docker_utils in kubernetes cluster."
    kubectl run `
        -it `
        --rm `
        --restart=Never `
        docker_utils `
        -- /bin/bash 
} elseif ($Docker) {
    docker run `
        -it `
        --rm `
        --network $Network `
        docker_utils `
        /bin/bash
}


    