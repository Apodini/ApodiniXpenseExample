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


struct AccountComponent: Component {
    @PathParameter var accountId: UUID
    
    
    var content: some Component {
        Group("accounts") {
            GetAllAccounts()
            CreateAccount()
                .operation(.create)
            Group($accountId) {
                GetAccount(id: $accountId)
                UpdateAccount(id: $accountId)
                    .operation(.update)
                DeleteAccount(id: $accountId)
                    .operation(.delete)
            }
        }
    }
}
