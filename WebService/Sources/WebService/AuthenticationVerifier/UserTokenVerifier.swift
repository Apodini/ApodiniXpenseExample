//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniAuthorization
import XpenseModel

struct UserTokenVerifier: AuthenticationVerifier {
    @Environment(\.xpenseModel) var xpenseModel
    
    @Throws(.unauthenticated,
            reason: "The user could not be authenticated",
            description: "Could not find a user for the supplied token!")
    var tokenNotFound: ApodiniError
    
    func initializeAndVerify(for authenticationInfo: String) throws -> User {
        guard let user = xpenseModel.user(forToken: authenticationInfo) else {
            throw tokenNotFound
        }
        
        return user
    }
}
