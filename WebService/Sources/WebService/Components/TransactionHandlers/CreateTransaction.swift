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


struct CreateTransaction: Handler {
    struct CreateTransactionMediator: Codable {
        let amount: Transaction.Cent
        let description: String
        var date = Date()
        let location: Coordinate
        let account: UUID
    }
    
    
    @Environment(\.xpenseModel) var xpenseModel
    @Environment(\.connection) var connection
    
    @Parameter(.http(.body)) var transaction: CreateTransactionMediator
    
    @Throws(.unauthenticated, reason: "The User is not Authenticated correctly") var userNotFound: ApodiniError
    @Throws(.notFound, reason: "The Account could not be found") var notFound: ApodiniError
    
    
    func handle() async throws -> Transaction {
        guard let user = xpenseModel.user(fromConnection: connection) else {
            throw userNotFound
        }
        
        guard xpenseModel.account(transaction.account)?.userID == user.id else {
            throw notFound
        }
        
        return try await xpenseModel.save(
            Transaction(
                amount: transaction.amount,
                description: transaction.description,
                date: transaction.date,
                location: transaction.location,
                account: transaction.account
            )
        )
    }
}
