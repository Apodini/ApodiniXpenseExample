//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini
import XpenseModel


struct DeleteTransaction: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    @Environment(\.connection) var connection
    
    @Binding var transactionId: UUID
    
    @Throws(.unauthenticated, reason: "The User is not Authenticated correctly") var userNotFound: ApodiniError
    @Throws(.notFound, reason: "The Account could not be found") var accountNotFound: ApodiniError
    @Throws(.notFound, reason: "The Transaction could not be found") var transactionNotFound: ApodiniError
    
    
    func handle() async throws -> Status {
        guard let user = xpenseModel.user(fromConnection: connection) else {
            throw userNotFound
        }
        
        guard let transaction = xpenseModel.transaction(transactionId),
              let account = xpenseModel.account(transaction.account),
              account.userID == user.id else {
            throw transactionNotFound
        }
        
        try await xpenseModel.delete(transaction: transactionId)
        
        return .noContent
    }
}
