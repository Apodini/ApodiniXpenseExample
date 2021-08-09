//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import XpenseModel


extension NumberFormatter {
    /// Converts a cent-value to a readable currency value. The currency symbol is added depending on your locale.
    ///
    /// Example: 152345 -> $1,52
    static let currencyAmount: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.multiplier = 0.01
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    /// Converts a cent-value to a readable currency value without the currency symbol.
    ///
    /// Example: 152345 -> 1,52
    static let decimalAmount: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.multiplier = 0.01
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    
    /// Converts an amount of cents into it's corresponding currency representation.
    /// We use this method to minimize the number of times in our code where we convert a Double to an NSNumber.
    ///
    /// Example: 152345 -> $1,52
    /// - Parameters:
    ///    - cent: The amount in cents
    /// - Returns: The amount converted into its currency representation if the conversion succeeded, otherwise nil
    static func currencyRepresentation(from cent: Transaction.Cent) -> String? {
        currencyAmount.string(from: NSNumber(value: Double(cent)))
    }
}
