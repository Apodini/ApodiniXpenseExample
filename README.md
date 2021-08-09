# Apodini Xpense Example

[![Build and Test](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/build-and-test.yml)
[![Build Docker Compose](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/docker-compose.yml/badge.svg)](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/docker-compose.yml)

This repository includes an example Apodini web service, a shared Swift Package, and an iOS App that can be used as a starting point for an Apodini web service.  

## Run the Xpense Example System

You can start the Apodini example web services on any system that supports [docker](https://www.docker.com) and [docker compose](https://docs.docker.com/compose/). Follow the instructions on https://docs.docker.com/compose/install/ to install docker and docker compose.
To start and test the web service, you can run the `$ docker compose up` command to start the web service. 

Xcode 13 (only available on macOS) is required to build and run the example client application. Follow the instructions on https://developer.apple.com/xcode/ to install the latest version of Xcode.

1. Opening the *Xoense.xcworkspace*. The workspace bundles the web services and the client application.
2. Select the *WebService* target, and then the *Xpense* target and start the web service as well as the app by following the instructions on [Running Your App in the Simulator or on a Device](https://developer.apple.com/documentation/xcode/running-your-app-in-the-simulator-or-on-a-device)

## System Functionality

The example system features an example application to manage accounts and transactions to keep track of your expeses and income.
Please note that this is a demo system and does not include sophisticated authentication or authorization mechanisms.
It includes examples of sharing code between a web service and the client application.

### Web Service API

You can test out the API by starting up the web service using the `$ docker compose up` command or use the `xpense` command line tool in the `Shared` Swift package.

### Client Application

You can use the functionality of the web service using the bundled client application.

## Contributing
Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/Apodini/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/Apodini/.github/blob/main/CODE_OF_CONDUCT.md) first.

## License
This project is licensed under the MIT License. See [License](https://github.com/Apodini/ApodiniXpenseExample/blob/develop/LICENSE) for more information.
