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
import Foundation


struct GetTransaction: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    
    @Binding var transactionId: UUID
    
    @Throws(.notFound, reason: "The Transaction could not be found") var transactionNotFound: ApodiniError
    
    @Authorized(User.self) var user
    
    func handle() throws -> Transaction {
        let user = try user()
        
        guard let transaction = xpenseModel.transaction(transactionId),
              let account = xpenseModel.account(transaction.account),
              account.userID == user.id else {
            throw transactionNotFound
        }
        
        return transaction
    }
}
