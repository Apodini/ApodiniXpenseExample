//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import XpenseModel

extension Application {
    /// Holds the `Model` of the web service.
    var xpenseModel: Model {
        guard let xpenseModel = self.storage[XpenseModelKey.self] else {
            self.storage[XpenseModelKey.self] = LocalStorageModel()
            return self.xpenseModel
        }
        return xpenseModel
    }
    
    struct XpenseModelKey: StorageKey {
        typealias Value = Model
    }
}
