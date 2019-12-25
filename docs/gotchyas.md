# Gotchya

### Nutget cannot access nuget.org from docker

**Error** NuGet.targets(119,5): error : Unable to load the service index for source https://api.nuget.org/v3/index.json.

**Solution source** [thread on github](https://github.com/NuGet/Home/issues/5358)

*If you are having this error in a docker container then run*

    docker system prune --volumes

*Then stop the docker app in your machine. Restart your machine and running everything from start.*

Try this next:

    dotnet nuget locals --clear all