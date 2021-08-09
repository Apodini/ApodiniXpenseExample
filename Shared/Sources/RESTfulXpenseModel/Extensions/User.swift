//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import XpenseModel


extension User {
    /// The `token` of the `User` transformed into the bearer token format
    var bearerToken: String? {
        tokens.first.map { "Bearer \($0)" }
    }
}
