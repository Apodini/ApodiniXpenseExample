//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: Model
/// The model of the Xpense App
open class Model {
    /// The `Account`s of the Xpense Web Service
    ///
    /// - Note: Only one user instance is present in the client application.
    public var users: Set<User>
    /// The `Account`s of the Xpense App
    public var accounts: Set<Account> {
        didSet {
            accountsDidSet()
        }
    }
    /// The `Transaction`s of the Xpense App
    public var transactions: Set<Transaction> {
        didSet {
            transactionsDidSet()
        }
    }
    /// A `XpenseServiceError` that should be displayed to the user in case of an error in relation with the Xpense Web Service
    public var webServiceError: XpenseServiceError? {
        didSet {
            webServiceErrorDidSet()
        }
    }
    
    /// The `User` of the Xpense App
    public var user: User? {
        users.first
    }
    
    
    /// Initializes a new `Model` for the Xpense app
    /// - Parameters:
    ///    - users: The `User`s of the Xpense App
    ///    - accounts: The `Account`s of the Xpense App
    ///    - transactions: The `Transaction`s of the Xpense App
    init(users: Set<User> = [], accounts: Set<Account> = [], transactions: Set<Transaction> = []) {
        self.users = users
        self.accounts = accounts
        self.transactions = transactions
    }
    
    
    #if canImport(Combine)
    /// Called when a new `User` was set to the `user` property, calls the `ObservableObject` `objectWillChange` Publisher
    open func userDidSet() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    /// Called when a new `Account` was set to the `accounts` property, calls the `ObservableObject` `objectWillChange` Publisher
    open func accountsDidSet() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    /// Called when a new `Transaction` was set to the `transactions` property, calls the `ObservableObject` `objectWillChange` Publisher
    open func transactionsDidSet() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    /// Called when a new `XpenseServiceError` was set to the `webServiceError` property, calls the `ObservableObject` `objectWillChange` Publisher
    open func webServiceErrorDidSet() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    #else
    /// Called when a new `User` was set to the `user` property
    open func userDidSet() {}
    
    /// Called when a new `Account` was set to the `accounts` property
    open func accountsDidSet() {}
    
    /// Called when a new `Transaction` was set to the `transactions` property
    open func transactionsDidSet() {}
    
    /// Called when a new `XpenseServiceError` was set to the `webServiceError` property
    open func webServiceErrorDidSet() {}
    #endif
    
    /// Get an `Account` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `Account` you wish to find.
    /// - Returns: The corresponding `Account` if there exists one with the specified id, otherwise nil
    public func account(_ id: Account.ID?) -> Account? {
        accounts.first(where: { $0.id == id })
    }
    
    /// Get an `User` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `User` you wish to find.
    /// - Returns: The corresponding `User` if there exists one with the specified id, otherwise nil
    public func user(_ id: User.ID?) -> User? {
        users.first(where: { $0.id == id })
    }
    
    /// Get an `User` for a specific token
    /// - Parameters:
    ///    - id: The token of the `User` you wish to find.
    /// - Returns: The corresponding `User` if there exists one with the specified tokeen, otherwise nil
    public func user(forToken token: String) -> User? {
        users.first(where: { $0.tokens.contains(token) })
    }
    
    /// Get a `Transaction` for a specific ID
    /// - Parameters:
    ///    - id: The id of the `Transaction` you wish to find.
    /// - Returns: The corresponding `Transaction` if there exists one with the specified id, otherwise nil
    public func transaction(_ id: Transaction.ID?) -> Transaction? {
        transactions.first(where: { $0.id == id })
    }
    
    /// Save a specified `Account`.
    /// - Parameters:
    ///    - account: The `Account` you wish to save.
    /// - Returns: A `Future` that completes once the resonse from the web service has arrived and has been processeds
    @discardableResult
    open func save(_ account: Account) async throws -> Account {
        var newAccount = account
        
        // Add an id in the case that the Account that should be saved is a new Account
        if newAccount.id == nil {
            newAccount.id = UUID()
        }
        
        accounts.update(with: newAccount)
        
        return newAccount
    }
    
    /// Save a specified `Transaction`.
    /// - Parameters:
    ///    - transaction: The `Transaction` you wish to save
    /// - Returns: A `Future` that completes once the resonse from the web service has arrived and has been processed
    @discardableResult
    open func save(_ transaction: Transaction) async throws -> Transaction {
        var newTransaction = transaction
        
        // Add an id in the case that the Transaction that should be saved is a new Transaction
        if newTransaction.id == nil {
            newTransaction.id = UUID()
        }
        
        transactions.update(with: newTransaction)
        
        return newTransaction
    }
    
    /// Delete a specified account and all transactions associated with the account.
    /// - Parameters:
    ///    - id: The id of the `Account` that you with to delete
    /// - Returns: A `Future` that completes once the resonse from the web service has arrived and has been processed
    open func delete(account id: Account.ID) async throws {
        if let account = account(id) {
            accounts.remove(account)
        }
    }
    
    /// Delete a specified transaction.
    /// - Parameters:
    ///    - id: The id of the `Transaction` that you with to delete
    /// - Returns: A `Future` that completes once the resonse from the web service has arrived and has been processed
    open func delete(transaction id: Transaction.ID) async throws {
        if let transaction = transaction(id) {
            transactions.remove(transaction)
        }
    }
    
    /// Provides the sign up functionality of the `Model`
    /// - Parameters:
    ///   - name: The name of the `User` that is used to authenticate the `User` in the future
    ///   - password: The password of the `User` that is used to authenticate the `User` in the future
    /// - Returns: The user that has been signed in
    @discardableResult
    open func signUp(_ name: String, password: String) async throws -> User {
        let user = User(name: name, password: password)
        users.update(with: user)
        userDidSet()
        return user
    }

    /// Verifies the credentials of a given username-password combination.
    /// - Parameters:
    ///   - name: The name of the ``User`` that is used to authenticate the ``User``
    ///   - password: The password of the ``User`` that is used to authenticate the ``User``
    /// - Returns: The ``User`` for the given username, if the password check succeeded.
    open func verifyCredentials(_ name: String, password: String) async throws -> User {
        guard let user = users.first(where: { $0.name == name }), user.verify(password: password) else {
            throw XpenseServiceError.loginFailed
        }
        return user
    }

    /// Creates a new login token for a given ``User`` instance.
    /// - Parameter user: The ``User`` instance for which a new authentication token shall be created.
    /// - Returns: Returns the freshly created auth token.
    open func createToken(for user: inout User) async -> String {
        let token = user.createToken()
        users.update(with: user)
        userDidSet()
        return token
    }
    
    /// Provides the login functionality of the `Model`
    /// - Parameters:
    ///   - name: The name of the `User` that is used to authenticate the `User`
    ///   - password: The password of the `User` that is used to authenticate the `User`
    /// - Returns: The token that can be used to further authenticate requests to the Xpense Web Service
    @discardableResult
    open func login(_ name: String, password: String) async throws -> String {
        var user = try await verifyCredentials(name, password: password)
        return await createToken(for: &user)
    }
    
    /// Logout the current `User` that is signed in and remove all personal data of the `User` stored in this `Model`
    open func logout() {
        users = []
        accounts = []
        transactions = []
    }
    
    /// Call this method to indicate to the model that the web service error has been displayed to the user
    public func resolveWebServiceError() {
        webServiceError = nil
    }
}

#if canImport(Combine)
extension Model: ObservableObject {}
#endif
