# Microservices

## Expected directory hierarchy

* $BESPIN_REPOS
  * \<microservicename\>
    * \<microservicename\>.sln
    * microserviceinfo.json
    * kubernetes
      * // yaml files
    * compose
      * docker-compose.yaml
      * docker-compose-init.yaml
    * \<microservicename\>
      * Dockerfile
      * config
        * // config files that can be replaced by environment
      * src
        * // source code


## Format of microserviceinfo.json

    // $BESPIN_REPOS/<microservicename>/microserviceinfo.json
    {
        // defaults to "/" representing "$BESPIN_REPOS//<microservicename>"
        "context": "<context in relation to ms repo root>",

        // defaults to "./Dockerfile" representing "$context/Dockerfile"
        "dockerfile": "./watch.Dockerfile"
        
        // image name will be <microservicename>-<imagesuffix>
        // image name will be all lowercase
        "imagesuffix" = "api-service"
    }    
