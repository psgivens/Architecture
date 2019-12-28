# Gotchya

### Nutget cannot access nuget.org from docker

**Error** NuGet.targets(119,5): error : Unable to load the service index for source https://api.nuget.org/v3/index.json.

**Solution source** [thread on github](https://github.com/NuGet/Home/issues/5358)

*If you are having this error in a docker container then run*

    docker system prune --volumes

*Then stop the docker app in your machine. Restart your machine and running everything from start.*

*Simpler fix*

    docker-compose rm
    docker-compose up

It may be a docker-compose caching issue. I'll try updating the start scripts to force new creation. 

Looking at [docker-compose up](https://docs.docker.com/compose/reference/up/) help, I think I may be able to fix it with either `--force-recreate` and/or `--renew-anon-volumes`. I'll have to wait until the next time the problem occurs to find out. 

If nothing else, try this next:

    dotnet nuget locals --clear all