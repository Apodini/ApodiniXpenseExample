//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import Foundation


struct TransactionComponent: Component {
    @PathParameter var transactionId: UUID
    
    
    var content: some Component {
        Group("transactions") {
            CreateTransaction()
                .operation(.create)
            GetAllTransactions()
            Group($transactionId) {
                GetTransaction(transactionId: $transactionId)
                UpdateTransaction(transactionId: $transactionId)
                    .operation(.update)
                DeleteTransaction(transactionId: $transactionId)
                    .operation(.delete)
            }
        }
    }
}
