//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import Foundation
import XpenseModel


struct UpdateAccount: Handler {
    struct UpdateAccountMediator: Codable {
        let name: String
    }
    
    
    @Environment(\.xpenseModel) var xpenseModel
    @Environment(\.connection) var connection
    
    @Binding var id: UUID
    
    @Parameter(.http(.body)) var updatedAccount: UpdateAccountMediator
    
    @Throws(.unauthenticated, reason: "The User is not Authenticated correctly") var userNotFound: ApodiniError
    @Throws(.notFound, reason: "The Account could not be found") var notFound: ApodiniError
    
    
    func handle() async throws -> Account {
        guard let user = xpenseModel.user(fromConnection: connection) else {
            throw userNotFound
        }
        
        guard xpenseModel.account(id)?.userID == user.id else {
            throw notFound
        }
        
        return try await xpenseModel.save(Account(id: id, name: updatedAccount.name, userID: user.id))
    }
}
