//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import XpenseModel


struct CreateAccount: Handler {
    struct CreateAccountMediator: Codable {
        let name: String
    }
    
    
    @Environment(\.xpenseModel) var xpenseModel
    @Environment(\.connection) var connection
    
    @Parameter(.http(.body)) var account: CreateAccountMediator
    
    @Throws(.unauthenticated, reason: "The User is not Authenticated correctly") var userNotFound: ApodiniError
    
    
    func handle() async throws -> Account {
        guard let user = xpenseModel.user(fromConnection: connection) else {
            throw userNotFound
        }
        
        return try await xpenseModel.save(Account(name: account.name, userID: user.id))
    }
}
