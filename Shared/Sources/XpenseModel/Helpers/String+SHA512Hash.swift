//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Crypto
import Foundation


extension String {
    var sha512hash: String {
        let data = Data(self.utf8)
        let hashBytes = SHA512.hash(data: data)
        return String(describing: hashBytes)
    }
}
