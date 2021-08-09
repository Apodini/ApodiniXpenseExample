//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


extension DateFormatter {
    /// Formatter that includes the date as well as the time.
    ///
    /// Example: September 3, 2018 at 3:38 PM
    static let dateAndTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    /// Formatter that includes only the date.
    ///
    /// Example: 9/3/18
    static let onlyDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
}
