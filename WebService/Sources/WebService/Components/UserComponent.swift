//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini


struct UserComponent: Component {
    var content: some Component {
        Group("users") {
            CreateUser()
                .operation(.create)
        }
        Group("login") {
            Login()
                .operation(.create)
        }
    }
}
