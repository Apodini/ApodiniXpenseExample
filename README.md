<!--

This source file is part of the Apodini Xpense Example open source project

SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>

SPDX-License-Identifier: MIT

-->

# Apodini Xpense Example

[![Build and Test](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/build-and-test.yml)
[![Build Docker Compose](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/docker-compose.yml/badge.svg)](https://github.com/Apodini/ApodiniXpenseExample/actions/workflows/docker-compose.yml)

This repository includes an example Apodini web service, a shared Swift Package, and an iOS App that can be used as a starting point for an Apodini web service.  

## Run the Xpense Example System

You can start the Apodini example web services on any system that supports [docker](https://www.docker.com) and [docker compose](https://docs.docker.com/compose/). Follow the instructions on https://docs.docker.com/compose/install/ to install docker and docker compose.
To start and test the web service, you can run the `$ docker compose up` command to start the web service. 

Xcode 13 (only available on macOS) is required to build and run the example client application. Follow the instructions on https://developer.apple.com/xcode/ to install the latest version of Xcode.

1. Opening the *Xpense.xcworkspace*. The workspace bundles the web services and the client application.
2. Select the *WebService* target, and then the *Xpense* target and start the web service as well as the app by following the instructions on [Running Your App in the Simulator or on a Device](https://developer.apple.com/documentation/xcode/running-your-app-in-the-simulator-or-on-a-device)

## System Functionality

The example system features an example application to manage accounts and transactions to keep track of your expeses and income.
Please note that this is a demo system and does not include sophisticated authentication or authorization mechanisms.
It includes examples of sharing code between a web service and the client application.

### Web Service API

You can test out the API by starting up the web service using the `$ docker compose up` command or use the `xpense` command line tool in the `Shared` Swift package.

### Client Application

You can use the functionality of the web service using the bundled client application.

## Apodini Deployer Functionality

The system also demonstrates the usage of the Apodini Deployer functionality provided by the Apodini Deployer subsystem.
The web service includes the support for the Localhost process-based and AWS FaaS-based Deployment Provider.
You can use the following scripts to deploy the web service using the different Deployment Providers.

### Localhost Deployment Provider

```console
$ git clone https://github.com/Apodini/Apodini.git
$ cd Apodini
$ git checkout 0.8.0
$ swift run LocalhostDeploymentProvider ../WebService --product-name WebService
[...]
notice DeploymentTargetLocalhost : Compiling target 'WebService'
[...]
info DeploymentTargetLocalhost.ProxyServer : Server starting on 0.0.0.0:80
[...]
info org.apodini.application : Server starting on 0.0.0.0:52011
info org.apodini.application : Server starting on 0.0.0.0:52003
info org.apodini.application : Server starting on 0.0.0.0:52007
info org.apodini.application : Server starting on 0.0.0.0:52005
info org.apodini.application : Server starting on 0.0.0.0:52009
info org.apodini.application : Server starting on 0.0.0.0:52001
info org.apodini.application : Server starting on 0.0.0.0:52002
info org.apodini.application : Server starting on 0.0.0.0:52012
info org.apodini.application : Server starting on 0.0.0.0:52006
info org.apodini.application : Server starting on 0.0.0.0:52000
info org.apodini.application : Server starting on 0.0.0.0:52010
info org.apodini.application : Server starting on 0.0.0.0:52004
info org.apodini.application : Server starting on 0.0.0.0:52008
```

### AWS Lambda Deployment Provider

You need to install Docker on your machine to run the AWS Deployment Provider: https://docs.docker.com/get-docker/
The AWS Lambda Deployment providers needs valid AWS Credentials to deploy the web service to AWS Lambda functions.
You can create a credentials file by following the AWS CLI Documentation at https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html.
You have to create an S3 bucket that can be used to upload the AWS Lambda binaries.
AWS Access Key ID and the AWS Secret Access Key need to have access to the S3 Bucket used to upload the compiled binary to, create an configure AWS Lambda functions, create and configure an AWS API Gateway, and configure IAM roles to set up the AWS Lambda deployment.

```console
$ git clone https://github.com/Apodini/Apodini.git
$ cd Apodini
$ git checkout 0.8.0
$ swift run AWSLambdaDeploymentProvider deploy ../WebService --product-name WebService --s3-bucket-name apodinixpenseexample
[...]
notice apodini.ApodiniLambda : Preparing docker image
[...]
notice apodini.ApodiniLambda : Successfully built docker image. image name: apodini-lambda-builder
notice apodini.ApodiniLambda : Generating web service structure
[...]
notice apodini.ApodiniLambda : Successfully generated web service structure
notice apodini.ApodiniLambda : Compiling SPM target 'WebService' for lambda
[...]
notice apodini.ApodiniLambda : Deploying to AWS
[...]
notice apodini.ApodiniLambda.AWSIntegration : Creating lambda package
notice apodini.ApodiniLambda.AWSIntegration : Zipping lambda package
notice apodini.ApodiniLambda.AWSIntegration : Uploading lambda package to s3://apodinixpenseexample/apodini-lambda/lambda.out.zip
S3 upload done.
notice apodini.ApodiniLambda.AWSIntegration : Creating lambda functions for nodes in the web service deployment structure (#nodes: 13)
[...]
notice apodini.ApodiniLambda.AWSIntegration : Importing API definition into the API Gateway
notice apodini.ApodiniLambda.AWSIntegration : Updating API Gateway name
notice apodini.ApodiniLambda.AWSIntegration : Deployed 13 lambdas to api gateway w/ id 'GATEWAY_ID'
notice apodini.ApodiniLambda.AWSIntegration : Invoke URL: https://GATEWAY_ID.execute-api.eu-central-1.amazonaws.com/
notice apodini.ApodiniLambda : Done! Successfully applied the deployment.
```

The Deployment provider automatically decomposes the web service in 12 Lambda functions which are deployed behind an AWS Gateway.
You can delete the Lambda functions and API Gateway routes using the `remove-deployment` subcommand. If you keep the API Gateway you can use the Gateway ID in subsequent deployments instead of using `_createNew` as used in the commands above.
```console
$ swift run DeploymentTargetAWSLambda remove-deployment --api-gateway-api-id GATEWAY_ID --keep-api-gateway true
``` 

## Contributing
Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/Apodini/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/Apodini/.github/blob/main/CODE_OF_CONDUCT.md) first.

## License
This project is licensed under the MIT License. See [License](https://github.com/Apodini/ApodiniXpenseExample/blob/develop/LICENSE) for more information.
