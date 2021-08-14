//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniREST
import ApodiniAuthorization
import ApodiniAuthorizationBearerScheme
import ArgumentParser
import XpenseModel


// MARK: Account
/// The `WebService` instance that defines the Xpense Web Service
@main
struct XpenseWebService: WebService {
    @Flag(help: "Remove all users, accounts, and transactions when starting the web service.")
    var reset = false
    @Option
    var port: Int = 80
    
    
    var content: some Component {
        Group { // group of access restricted endpoints.
            AccountComponent()
            TransactionComponent()
        }.metadata {
            Authorize(User.self, using: BearerAuthenticationScheme(), verifiedBy: UserTokenVerifier())
        }

        UserComponent()
    }
    
    var configuration: Configuration {
        HTTPConfiguration(port: port)
        REST()
        EnvironmentValue(LocalStorageModel(reset: reset), \Application.xpenseModel)
    }
}
