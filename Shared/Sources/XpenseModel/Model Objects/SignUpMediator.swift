//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: SignUpMediator
/// A mediator to interface with the Xpense Web Service sign up process
public struct SignUpMediator: Codable {
    /// The name of the `User` that is send to and returned from the sign up process
    public let name: String
    /// The password of the `User` that is send to the Xpense Web Service
    public let password: String?
    
    
    /// - Parameters:
    ///   - name: The name of the `User` that is send to and returned from the sign up process
    ///   - password: The password of the `User` that is send to the Xpense Web Service
    public init(name: String, password: String? = nil) {
        self.name = name
        self.password = password
    }
}
