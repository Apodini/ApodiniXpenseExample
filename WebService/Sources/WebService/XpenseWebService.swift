//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniAuthorization
import ApodiniAuthorizationBearerScheme
import ApodiniDeploy
import ApodiniOpenAPI
import ApodiniREST
import ArgumentParser
import DeploymentTargetAWSLambdaRuntime
import DeploymentTargetLocalhostRuntime
import XpenseModel


// MARK: Account
/// The `WebService` instance that defines the Xpense Web Service
@main
struct XpenseWebService: WebService {
    @Option
    var port: Int = 80
    
    
    var content: some Component {
        Text("Welcome to the Xpense Web Service! 👋")
        Group { // group of access restricted endpoints.
            AccountComponent()
            TransactionComponent()
        }.metadata {
            Authorize(User.self, using: BearerAuthenticationScheme(), verifiedBy: UserTokenVerifier())
        }
        UserComponent()
    }
    
    var configuration: Configuration {
        HTTPConfiguration(bindAddress: .interface(port: port))
        REST {
            OpenAPI()
        }
        ApodiniDeploy(runtimes: [LocalhostRuntime<Self>.self, LambdaRuntime<Self>.self])
    }
}
