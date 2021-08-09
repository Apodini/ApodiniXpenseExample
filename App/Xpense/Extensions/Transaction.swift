//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import XpenseModel


extension Transaction {
    /// Converts this `Transaction`'s amount into a textual representation
    public var amountDescription: String {
        NumberFormatter.currencyRepresentation(from: amount) ?? ""
    }
    
    /// Converts this `Transaction`'s date into a textual representation
    public var dateDescription: String {
        DateFormatter.dateAndTime.string(from: date)
    }
    
    /// Convert's this `Transaction`'s date into a relative description
    ///
    /// Example: 45 minutes ago
    public var relativeDateDescription: String {
        if let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff < 24 {
            return RelativeDateTimeFormatter.namedAndSpelledOut.localizedString(for: date, relativeTo: Date())
        }
        
        return DateFormatter.onlyDate.string(from: date)
    }
}
