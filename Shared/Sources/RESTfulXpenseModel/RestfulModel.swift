//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import XpenseModel


// MARK: RestfulModel
/// Handles storing and loading Xpense relevant data from and to a RESTful web service.
public class RestfulModel: LocalStorageModel {
    /// The base route that is used to access the RESTful web service
    static var baseURL: URL = {
        guard let baseURL = URL(string: "http://localhost/v1/") else {
            fatalError("Coult not create the base URL for the Xpense Web Service")
        }
        return baseURL
    }()
    
    
    /// Creates a new `RestfulModel` and loads the current `User`s, `Account`s and `Transaction`s
    public init() {
        super.init()
        userDidSet()
    }
    
    override public func userDidSet() {
        super.userDidSet()
        
        guard let token = user?.bearerToken else {
            return
        }
        NetworkManager.authorization = token
        
        Task {
            await self.refresh()
        }
    }
    
    @discardableResult
    override public func save(_ account: Account) async throws -> Account {
        try await saveElement(account, to: \.accounts)
    }
    
    @discardableResult
    override public func save(_ transaction: Transaction) async throws -> Transaction {
        try await saveElement(transaction, to: \.transactions)
    }
    
    override public func delete(account id: Account.ID) async throws {
        if let account = account(id) {
            try await delete(account, in: \.accounts)
            await refresh()
        }
    }
    
    override public func delete(transaction id: Transaction.ID) async throws {
        if let transaction = transaction(id) {
            try await delete(transaction, in: \.transactions)
            await refresh()
        }
    }
    
    @discardableResult
    override public func signUp(_ name: String, password: String) async throws -> User {
        let user = try await sendSignUpRequest(name, password: password)
        users.update(with: user)
        userDidSet()
        return user
    }
    
    @discardableResult
    override public func login(_ name: String, password: String) async throws -> String {
        let user = try await sendLoginRequest(name, password: password)
        users.update(with: user)
        userDidSet()
        
        guard let token = user.tokens.first else {
            throw XpenseServiceError.loginFailed
        }
        return token
    }
    
    /// Sets the `webServiceError` of the `Model` and returns the error to be processed by `Publishers`
    /// - Parameter error: The `XpenseServiceError` that should be set
    /// - Returns: The `XpenseServiceError` passed in as an argument
    func setWebServiceError(to error: XpenseServiceError) -> XpenseServiceError {
        self.webServiceError = error
        return error
    }
    
    /// Refreshes the `Accounts` and `Transaction` in the `Model`
    private func refresh() async {
        do {
            self.accounts = try await Set(Account.get())
        } catch {
            self.webServiceError = .loadingFailed(Account.self)
        }
        
        do {
            self.transactions = try await Set(Transaction.get())
        } catch {
            self.webServiceError = .loadingFailed(Transaction.self)
        }
    }
}
