# Building Microservice

## docker-compose

1. Build base image

       Build-CoreDbgStage.ps1

2. Build the microservice

       Build-Microservice.ps1 -ServiceName <servicename>

       # Note: You can get a list of microservices using the -List parameter
       Build-Microservice.ps1 -ServiceName <servicename>

3. Initialize the environment

       # In .\compose, runs:
       #   docker-compose -f docker-compose-init.yaml up
       Initialize-Microservice.ps1 -ServiceName <servicename> -Compose

4. Run the microservice in local docker

       # In .\compose, runs:
       #   docker-compose -f docker-compose.yaml up
       Start-Microservice.ps1 -ServiceName <servicename> -Compose

5. Use ctrl-c to stop       


## kubernetes

1. Build base image

       Build-CoreDbgStage.ps1

2. Build the microservice

       Build-Microservice.ps1 -ServiceName <servicename>

       # Note: You can get a list of microservices using the -List parameter
       Build-Microservice.ps1 -ServiceName <servicename>

3. Initialize the environment

       # TODO: document k8s processing
       Initialize-Microservice.ps1 -ServiceName <servicename> -K8s

4. Run the microservice in local docker

       # TODO: document k8s processing
       Start-Microservice.ps1 -ServiceName <servicename> -K8s

5. Use ctrl-c to stop       