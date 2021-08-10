//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniAuthorization
import Foundation
import XpenseModel


struct UpdateAccount: Handler {
    struct UpdateAccountMediator: Codable {
        let name: String
    }
    
    
    @Environment(\.xpenseModel) var xpenseModel
    
    @Binding var id: UUID
    
    @Parameter(.http(.body)) var updatedAccount: UpdateAccountMediator
    
    @Throws(.notFound, reason: "The Account could not be found") var notFound: ApodiniError
    
    var user = Authorized<User>()
    
    func handle() async throws -> Account {
        let user = try user()
        
        guard xpenseModel.account(id)?.userID == user.id else {
            throw notFound
        }
        
        return try await xpenseModel.save(Account(id: id, name: updatedAccount.name, userID: user.id))
    }
    
    var metadata: Metadata {
        Operation(.update)
    }
}
