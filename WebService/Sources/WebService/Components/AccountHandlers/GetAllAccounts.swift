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


struct GetAllAccounts: Handler {
    @Environment(\.xpenseModel) var xpenseModel

    @Authorized(User.self) var user
    
    func handle() throws -> [Account] {
        let user = try user()
        return user.accounts(xpenseModel)
    }
}
