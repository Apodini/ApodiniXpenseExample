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


struct CreateAccount: Handler {
    struct CreateAccountMediator: Codable {
        let name: String
    }
    
    
    @Environment(\.xpenseModel) var xpenseModel
    
    @Parameter(.http(.body)) var account: CreateAccountMediator
    
    var user = Authorized<User>()
    
    func handle() async throws -> Account {
        let user = try user()
        
        return try await xpenseModel.save(Account(name: account.name, userID: user.id))
    }
    
    var metadata: Metadata {
        Operation(.create)
    }
}
