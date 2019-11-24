# Repositories

This document describes ther relevant repositories for building on my platform

### Architecture (this)

'Architecture' describes other project, and provides tools and documentation for other projects. The main contributors to this project should be Architects.

* Documentation relevant across the platform
* Scripts used accross the platform
* Infrastructure to be used in local development such as Router (envoy) to be used in Microk8s

### WebClient.Design (front end)

'WebClient.Design' provides the UI elements for other projects to use in the form of CSS & JS files as well as React Components. These are meant to be copied into other projects. The main contributor to this project should be the UI developer.

* CSS & JS used for UI
* HTML to demonstrate the use of CSS & JS
* Reusable React components such as InputText and Button
* React files demonstrating use of CSS & JS along with reusable React components
* Scripts to copy files into other projects

### BasicService.API (back end)

'BasicService.API' is a rest API service designed to demonstrate basic functionality that is necessary in any micro service. It is meant to be used as a starting point for creating services with more functionality, that don't need event sourcing. The main contributors to this project are the Architects, but may include developers as well. 

* Demonstrates basic connection (ping)
* Demonstrates context-auth
* Demonstrates database connectivity
* Demonstrates hydrating with docker-compose

BasicService.API has an objective to work using context-authn when developing, but use system provided auth through gateways in production. 

### BasicService.SPA (front end)

'BasicService.SPA' is a client to 'BasicService.API' designed to demonstrate basic functionality that is necessary in any client to a micro service. It is meant to be used as a starting point for creating clients with more functionality. The main contributors to this project are the Architects, but may include developers as well.

This project demonstrates 
* basic connection (ping)
* context-auth
* database connectivity
* hydrating with docker-compose

BasicService.API has an objective to work using context-authn when developing, but use system provided auth through javascript libraries in production. 



