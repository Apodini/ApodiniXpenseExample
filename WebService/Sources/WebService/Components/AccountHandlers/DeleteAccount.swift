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


struct DeleteAccount: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    
    @Binding var id: UUID
    
    @Throws(.notFound, reason: "The Account could not be found") var notFound: ApodiniError
    
    @Authorized(User.self) var user
    
    
    var metadata: Metadata {
        Operation(.delete)
    }
    
    
    func handle() async throws -> Status {
        let user = try user()
        
        guard let account = xpenseModel.account(id),
              account.userID == user.id else {
            throw notFound
        }
        
        try await xpenseModel.delete(account: id)
        
        return .noContent
    }
}
