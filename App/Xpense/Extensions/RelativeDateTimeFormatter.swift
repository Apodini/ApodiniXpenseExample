//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


extension RelativeDateTimeFormatter {
    /// Gives a relative date description.
    ///
    /// Example: 45 minutes ago
    static var namedAndSpelledOut: RelativeDateTimeFormatter {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.dateTimeStyle = .named
        relativeDateTimeFormatter.unitsStyle = .full
        return relativeDateTimeFormatter
    }
}
