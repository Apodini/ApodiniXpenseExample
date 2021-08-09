//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


extension XpenseModel.Transaction.Classification {
    ///  A color representing the `Classification`
    ///
    ///  green for an `Classification.income`
    ///
    ///  red for an `Classification.expense`
    var color: Color {
        self == .income ? .green : .red
    }
}
