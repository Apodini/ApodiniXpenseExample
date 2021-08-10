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


struct GetAllTransactions: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    
    var user = Authorized<User>()
    
    func handle() throws -> [Transaction] {
        let user = try user()
        return user.transactions(xpenseModel)
    }
}
