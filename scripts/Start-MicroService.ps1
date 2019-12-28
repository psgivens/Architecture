#!/usr/bin/pwsh

# Maybe I have to do this all the time with microk8s
# see: https://microk8s.io/docs/

param (
    # Parameter help description
    [Parameter(Mandatory=$true,
    ParameterSetName="local"
    )]
    [switch]
    $Local,

    # Parameter help description
    [Parameter(Mandatory=$true,
    ParameterSetName="compose"
    )]
    [switch]
    $Compose,
    
    # Parameter help description
    [Parameter(Mandatory=$true,
    ParameterSetName="k8s"
    )]
    [switch]
    $K8s,
        
    # Parameter help description
    [Parameter(Mandatory=$true)]
    # [ValidateSet(
    #     "iam-id-mgmt",
    #     "router"
    # )]
    [string]
    $ServiceName,
    [Parameter(Mandatory=$false)]
    [ValidateSet(
        "db",
        "api",
        "all"
    )]
    [string]
    $Part = "all",
    [Parameter(Mandatory=$false,
    ParameterSetName="k8s"
    )]
    [bool]
    $NodePort,
    [Parameter(Mandatory=$false,
    ParameterSetName="k8s"
    )]
    [bool]
    $SkipService,
    [Parameter(Mandatory=$false,
    ParameterSetName="k8s"
    )]
    [bool]
    $Cold
)

$details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

if ($Local) {
    switch ($Part.ToLower()) {
        "db" {
            Write-Host ("Launching ``docker-compose -f docker-compose-db.yml up`` from " + "$env:BESPIN_REPOS/$ServiceName/compose")
            docker-compose -f docker-compose-db.yml --renew-anon-volumes up

        }
        default    {  
            # Write-Host ("Launching ``docker-compose up`` from " + "$env:BESPIN_REPOS/$ServiceName/compose")
            # docker-compose up
        }
    }
} elseif ($Compose) {
    Push-Location "$env:BESPIN_REPOS/$ServiceName/compose"

    switch ($Part.ToLower()) {
        "db" {
            Write-Host ("Launching ``docker-compose -f docker-compose-init.yml up`` from " + "$env:BESPIN_REPOS/$ServiceName/compose")
            docker-compose -f docker-compose-init.yml up
        }
        default    {  
            Write-Host ("Launching ``docker-compose up`` from " + "$env:BESPIN_REPOS/$ServiceName/compose")
            docker-compose up
        }
    }
    Pop-Location
    
} else {
     
    # $kubeconfig = $details["kubernetes"]
    # $details = . "$PSScriptRoot/Get-MicroServiceDetails.ps1" -ServiceName $ServiceName

    $ServicePath = "$env:BESPIN_REPOS/$ServiceName"

    if (-not (Test-Path $ServicePath)) {
        Write-Host "$servicePath not found"
        throw "$servicePath not found"
        exit
    }

    $servicename_lower = $ServiceName.ToLower()
    $kubeconfig = "$ServicePath/kubernetes"


    switch ($Part.ToLower()) {
        "db" {  
            if (-not $SkipService) {
                if ($Cold) {
                    . "$PSScriptRoot/Initialize-MicroServicePart.ps1" -ServiceName $ServiceName -Part "volume" 
                    . "$PSScriptRoot/Initialize-MicroServicePart.ps1" -ServiceName $ServiceName -Part "configmap" 
                }

                kubectl create -f "$kubeconfig/$servicename_lower-db-statefulset.yaml"

                Write-Host "Wait for the service to become online..."
                $retries=10
                foreach ($i in 1..$retries) {
                    $cmd = "kubectl get pods -o json -l app=$ServiceName-db"
                    $phase = Invoke-Expression $cmd | ConvertFrom-Json | ForEach-Object {$_.items.status.phase}
                    Write-Host "phase: $phase"
                    if ($phase -eq 'Running') { 
                        Write-Host "System ready"
                        break }
                    if ($i -eq $retries) { 
                        Write-Host "Match not found after $retries retries"
                        exit
                    }
                    Start-Sleep 1
                }

                if ($Cold) {
                    . "$PSScriptRoot/Start-MicroServiceJob.ps1" -ServiceName $ServiceName -Job "initialize-db" 
                }
            }
            if ($NodePort) {
                # Necessary if we are debugging an app running on our local machine. 
                kubectl create -f "$kubeconfig/$servicename_lower-db-service-nodeport.yaml"
            }        
        }
        "api" {                
            if (-not $SkipService) {
                kubectl create -f "$kubeconfig/$servicename_lower-api-service-replicaset.yaml"

                kubectl create -f "$kubeconfig/$servicename_lower-api-service-public.yaml"
            }

            if ($NodePort) {
                # Necessary if we are debugging an app running on our local machine. 
                kubectl create -f "$kubeconfig/$servicename_lower-api-service-nodeport.yaml"
            }        
        }
        "all" {
            . "$PSScriptRoot/Start-MicroService.ps1" -ServiceName $ServiceName -Part "db" -NodePort $NodePort -SkipService $SkipService -Cold $Cold -K8s
            . "$PSScriptRoot/Start-MicroService.ps1" -ServiceName $ServiceName -Part "api" -NodePort $NodePort -SkipService $SkipService -Cold $Cold -K8s
        }
        Default {
            Get-Help "$PSScriptRoot/Start-MicroService.ps1" 
        }
    }

}
