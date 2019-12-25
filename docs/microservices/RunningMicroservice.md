# Building and Running Microservice

**Note** You can get a list of microservices with

    Get-MicroServiceDetails -List

**Note** You can get a list of microservice commands with

    Get-McsvcCommands 


## Running locally

1. Initialize the environment

       # Create the network
       docker network create pomodoro-net

       # You may also have to create volumes for your service. 

2. Build the microservice

       Publish-Microservice.ps1 -ServiceName <servicename>

3. Initialize the environment

       # In .\compose, runs:
       #   docker-compose -f docker-compose-init.yml up
       Initialize-Microservice.ps1 -ServiceName <servicename> -Compose

4. Run the database

       # In .\compose, runs:
       #   docker-compose -f docker-compose-db.yml up
       Start-Microservice.ps1 -ServiceName <servicename> -Compose -Part db

5. Run the microservice locally

       # In the directory of the microservice:
       dotnet watch run

6. Use ctrl-c to stop       


## docker-compose

1. Initialize the environment

       # Create the network
       docker network create pomodoro-net

       # You may also have to create volumes for your service. 

2. Build base image

       Build-CoreDbgStage.ps1

3. Build the microservice

       Publish-Microservice.ps1 -ServiceName <servicename>

4. Initialize the environment

       # In .\compose, runs:
       #   docker-compose -f docker-compose-init.yaml up
       Initialize-Microservice.ps1 -ServiceName <servicename> -Compose

5. Run the microservice in local docker

       # In .\compose, runs:
       #   docker-compose -f docker-compose.yaml up
       Start-Microservice.ps1 -ServiceName <servicename> -Compose

6. Use ctrl-c to stop       


## kubernetes

1. Build base image

       Build-CoreDbgStage.ps1

2. Build the microservice

       Publish-Microservice.ps1 -ServiceName <servicename>

3. Initialize the environment

       Initialize-Microservice.ps1 -ServiceName <servicename> -K8s

4. Run the microservice in local docker

       Start-Microservice.ps1 -ServiceName <servicename> -K8s

5. Stop the service 

       Stop-Microservice.ps1 -ServiceName <servicename> -K8s
