//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import XpenseModel


extension Model {
    /// The current total balance of all `Account`s that are stored in the `Model` instance
    public var currentBalance: Transaction.Cent {
        accounts.reduce(0) { $0 + $1.balance(self) }
    }
}
