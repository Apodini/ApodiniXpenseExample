//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: Account
/// Represents a single account that consists of a set of transactions.
public struct Account {
    /// The stable identity of the entity associated with self
    public var id: UUID?
    /// The name of the `Account`
    public var name: String
    /// The owner of the `Account`
    public var userID: User.ID
    
    
    /// - Parameters:
    ///   - id: The stable identity of the `Account`
    ///   - name: The name of the `Account`
    public init(id: UUID? = nil, name: String, userID: User.ID) {
        self.id = id
        self.name = name
        self.userID = userID
    }
    
    
    /// Finds all transactions that belong to this account.
    /// - Parameters:
    ///     - model: The model to read from
    /// - Returns: All transactions in this account
    public func transactions(_ model: Model) -> [Transaction] {
        model.transactions.filter { $0.account == id }
    }
}


// MARK: Account: CustomStringConvertible
extension Account: CustomStringConvertible {
    public var description: String {
        name
    }
}


// MARK: Account: Identifiable
extension Account: Identifiable { }


// MARK: Account: Hashable
extension Account: Hashable {
    public static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: Account: Comparable
extension Account: Comparable {
    public static func < (lhs: Account, rhs: Account) -> Bool {
        lhs.name < rhs.name
    }
}


// MARK: Account: LocalFileStorable
extension Account: LocalFileStorable { }
