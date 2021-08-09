//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


extension Date {
    /// Create a new date a certain amount of minutes from now.
    /// - Parameters:
    ///     - minutesFromNow: The amount of minutes the event shall be in the future.
    init(minutesFromNow minutes: Int) {
        self = Calendar.current.date(byAdding: .minute, value: minutes, to: Date()) ?? Date()
    }
}
