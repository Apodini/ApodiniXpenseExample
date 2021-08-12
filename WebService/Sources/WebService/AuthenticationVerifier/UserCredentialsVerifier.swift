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

struct UserCredentialsVerifier: AuthenticationVerifier {
    @Environment(\.xpenseModel) var xpenseModel
    
    @Throws(.unauthenticated, reason: "The provided credentials are not correct")
    var unauthenticatedError: ApodiniError
    
    typealias AuthenticationInfo = (username: String, password: String)
    
    func initializeAndVerify(for authenticationInfo: AuthenticationInfo) async throws -> User {
        do {
            return try await xpenseModel.verifyCredentials(authenticationInfo.username, password: authenticationInfo.password)
        } catch {
            throw unauthenticatedError
        }
    }
}
