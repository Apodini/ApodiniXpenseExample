//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniAuthorization
import ApodiniAuthorizationBasicScheme
import Foundation
import XpenseModel


struct Login: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    
    @Authorized(User.self) var user
    
    
    var metadata: Metadata {
        Operation(.create)
        
        Authorize(User.self, using: BasicAuthenticationScheme(), verifiedBy: UserCredentialsVerifier())
    }
    
    
    func handle() async throws -> String {
        var user = try user()
        let token = await xpenseModel.createToken(for: &user)
        
        return token
    }
}
