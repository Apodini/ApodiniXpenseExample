//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import XpenseModel


struct GetAllTransactions: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    @Environment(\.connection) var connection
    
    @Throws(.unauthenticated, reason: "The User is not Authenticated correctly") var userNotFound: ApodiniError
    
    
    func handle() throws -> [Transaction] {
        guard let user = xpenseModel.user(fromConnection: connection) else {
            throw userNotFound
        }

        return user.transactions(xpenseModel)
    }
}
