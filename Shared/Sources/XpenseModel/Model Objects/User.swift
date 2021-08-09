//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: User
/// Represents a User of the Xpense Application
public struct User: Identifiable, LocalFileStorable {
    /// The name of the User of the Xpense Application
    public private(set) var name: String
    /// Tokens that are used to authenticate the `User` on the XpenseWeb Service
    ///
    ///  - Note: Normally only one token is present on the client side
    public private(set) var tokens: Set<String> = []
    /// The hash value of the password stored on the web service side of the Xpense application
    ///
    ///  - Note: This value should be empty on the client side
    public private(set) var passwordHash: String?
    
    
    public var id: String {
        name
    }
    
    /// - Parameters:
    ///   - name: The name of the User of the Xpense Application
    ///   - token: The token that is used to authenticate the `User` on the XpenseWeb Service
    public init(name: String, token: String? = nil) {
        self.name = name
        
        if let token = token {
            self.tokens = [token]
        }
    }
    
    /// - Parameters:
    ///   - name: The name of the User of the Xpense Application
    ///   - password: The password that is used to authenticate the `User` on the XpenseWeb Service
    public init(name: String, password: String) {
        self.name = name
        self.passwordHash = password.sha512hash
    }
    
    
    @discardableResult
    public mutating func createToken() -> String {
        let token = Data(
            [UInt8](repeating: 0, count: 32)
                .map { _ in
                    UInt8.random(in: UInt8.min...UInt8.max)
                }
        )
            .base64EncodedString()
        
        self.tokens.insert(token)
        return token
    }
    
    public func verify(password: String) -> Bool {
        self.passwordHash == password.sha512hash
    }
    
    public func accounts(_ model: Model) -> [Account] {
        model.accounts.filter { account in
            account.userID == self.id
        }
    }
    
    public func transactions(_ model: Model) -> [Transaction] {
        accounts(model).flatMap { account in
            account.transactions(model)
        }
    }
}


// MARK: User: Codable
extension User: Codable {}


// MARK: User: Hashable
extension User: Hashable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
