# Microservices

### Expected directory hierarchy

* $POMODORO_REPOS
* * \<microservicename\>
* * \<microservicename\>.sln
* * * microserviceinfo.json
* * * kubernetes
* * * compose
* * * * \<microservicename\>
* * * * * Dockerfile
* * * * * config
* * * * * src


### Format of microserviceinfo.json

    // $POMODORO_REPOS/<microservicename>/microserviceinfo.json
    {
        // defaults to "/" representing "$POMODORO_REPOS//<microservicename>"
        "context": "<context in relation to ms repo root>",

        // defaults to "/Dockerfile" representing "$POMODORO_REPOS/<microservicename>/Dockerfile"
        "dockerfile": "$location/watch.Dockerfile"
        
        // image name will be <microservicename>-<imagesuffix>
        // image name will be all lowercase
        "imagesuffix" = "api-service"
    }    
