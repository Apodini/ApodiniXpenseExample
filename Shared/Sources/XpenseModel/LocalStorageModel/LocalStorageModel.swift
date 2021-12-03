//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: LocalStorageModel
/// A `Model` that persists its content on the local storage e.g. using the file system
/// The `LocalStorageModel` artifically delays storing and loading elements to simulate a network request or database access
open class LocalStorageModel: Model {
    /// Creates a `Model` that stores information locally on the filesystem
    public init(reset: Bool = false) {
        if reset {
            User.removeFile()
            Account.removeFile()
            Transaction.removeFile()
        }
        
        super.init(
            users: User.loadFromFile(),
            accounts: Account.loadFromFile(),
            transactions: Transaction.loadFromFile()
        )
    }
    
    /// Initializes a new `LocalStorageModel` for the Xpense app
    /// - Parameters:
    ///    - users: The `User`s of the Xpense App
    ///    - accounts: The `Account`s of the Xpense App
    ///    - transactions: The `Transaction`s of the Xpense App
    override init(users: Set<User> = [], accounts: Set<Account> = [], transactions: Set<Transaction> = []) {
        super.init(users: users, accounts: accounts, transactions: transactions)
    }
    
    
    override open func accountsDidSet() async {
        await super.accountsDidSet()
        accounts.saveToFile()
    }
    
    override open func transactionsDidSet() async {
        await super.transactionsDidSet()
        transactions.saveToFile()
    }
    
    override open func userDidSet() async {
        await super.userDidSet()
        users.saveToFile()
    }
    
    @discardableResult
    override open func save(_ account: Account) async throws -> Account {
        let newAccount = try await super.save(account)
        try await Task.sleep(nanoseconds: 250_000_000) // Delay for 0.25s
        return newAccount
    }
    
    @discardableResult
    override open func save(_ transaction: Transaction) async throws -> Transaction {
        let newTransaction = try await super.save(transaction)
        try await Task.sleep(nanoseconds: 250_000_000) // Delay for 0.25s
        return newTransaction
    }
    
    override open func delete(account id: Account.ID) async throws {
        try await super.delete(account: id)
        try await Task.sleep(nanoseconds: 250_000_000) // Delay for 0.25s
    }
    
    override open func delete(transaction id: Transaction.ID) async throws {
        try await super.delete(transaction: id)
        try await Task.sleep(nanoseconds: 250_000_000) // Delay for 0.25s
    }
    
    @discardableResult
    override open func signUp(_ name: String, password: String) async throws -> User {
        let user = try await super.signUp(name, password: password)
        try await Task.sleep(nanoseconds: 500_000_000) // Delay for 0.5s
        return user
    }
    
    @discardableResult
    override open func login(_ name: String, password: String) async throws -> String {
        let token = try await super.login(name, password: password)
        try await Task.sleep(nanoseconds: 500_000_000) // Delay for 0.5s
        return token
    }
    
    override open func logout() {
        User.removeFile()
        Account.removeFile()
        Transaction.removeFile()
        
        super.logout()
    }
}
