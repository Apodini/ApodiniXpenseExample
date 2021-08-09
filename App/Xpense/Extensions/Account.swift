//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import XpenseModel


extension Account {
    /// Calculates the current balance on this account
    /// - Parameters:
    ///     - model: The model to read from
    /// - Returns: The current balance of this account in cents
    func balance<M: Model>(_ model: M) -> Transaction.Cent {
        transactions(model).reduce(0) { $0 + $1.amount }
    }
    
    ///  Calculates the current balance on this account and converts it to a human-readable currency format.
    ///  - Parameters:
    ///     - model: The model to read from
    ///  - Returns: The current balance of this account in a human readable form
    func balanceRepresentation<M: Model>(_ model: M) -> String? {
        NumberFormatter.currencyRepresentation(from: self.balance(model))
    }
}
