//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import ArgumentParser
import Foundation
import RESTfulXpenseModel


@main
class Xpense: ParsableCommand {
    @Argument(help: "The name of the user of the Xpense app")
    var name: String = "Paul"
    
    @Argument(help: "The password for the user of the Xpense app")
    var password: String = "Password"
    
    @Option(help: "The password for the user of the Xpense app")
    var createNewAccount = true
    
    
    required init() { }
    
    
    func run() throws {
        Task {
            let model = RestfulModel()
            
            if createNewAccount {
                try await model.signUp(name, password: password)
            } else {
                try await model.login(name, password: password)
            }
            
            try await createAccount("\(self.name)'s Wallet", using: model)
            try await createAccount("\(self.name)'s Bank Account", using: model)
            
            try await createTransaction(amount: -100, description: "Brezn", using: model)
            try await createTransaction(amount: -120, description: "Spezi", using: model)
            
            try await updateTransactionAndAccount(model)
            
            try await deleteTransaction(model)
            
            print(
                """
                -------
                Finished with the xpense CLI
                \(model.accounts)
                \(model.transactions)
                """
            )
            
            Xpense.exit()
        }
        RunLoop.main.run()
    }
    
    private func createAccount(_ name: String, using model: RestfulModel) async throws {
        try await model.save(Account(name: name, userID: name))
        
        print(
            """
            -------
            Created account
            \(model.accounts)
            """
        )
    }
    
    private func createTransaction(amount: Int, description: String, using model: RestfulModel) async throws {
        guard let accountId = model.accounts.first(where: { $0.name == "\(self.name)'s Wallet" })?.id else {
            fatalError("Could not get the correct Account ID for \(self.name)'s Wallet")
        }

        let newTransaction = Transaction(
            amount: amount,
            description: description,
            location: Coordinate(48.262432, 11.667976),
            account: accountId
        )
        
        try await model.save(newTransaction)
        
        print(
            """
            -------
            Created a transaction:
            \(model.transactions)
            """
        )
    }
    
    private func updateTransactionAndAccount(_ model: RestfulModel) async throws {
        guard var account = model.accounts.first(where: { $0.name == "\(self.name)'s Bank Account" }) else {
            fatalError("Expected an Account with the name \"\(self.name)'s Bank Account\"")
        }
        account.name = "\(self.name)'s Second Bank Account"
        
        try await model.save(account)
        
        print(
            """
            -------
            Renamed an account:
            \(model.accounts)
            """
        )
        
        guard var transaction = model.transactions.first(where: { $0.description == "Brezn" }) else {
            fatalError("Expected a Transaction with the description \"Brezn\"")
        }
        transaction.date = Date()
        transaction.amount = -80
        
        try await model.save(transaction)
        
        print(
            """
            -------
            Change a transaction:
            \(model.transactions)
            """
        )
    }
    
    private func moveTransactionToNewAccount(_ model: RestfulModel) async throws {
        guard let newAccountId = model.accounts.first(where: { $0.name == "\(self.name)'s Second Bank Account" })?.id else {
            fatalError("Expected an Account with the name \"\(self.name)'s Second Bank Account\"")
        }
        guard var transaction = model.transactions.first(where: { $0.description == "Brezn" }) else {
            fatalError("Expected a Transaction with the description \"Brezn\"")
        }
        transaction.date = Date()
        transaction.amount = -90
        transaction.account = newAccountId
        
        try await model.save(transaction)
        
        print(
            """
            -------
            Change a transaction and moved it to a new account:
            \(model.transactions)
            """
        )
    }
    
    private func deleteTransaction(_ model: RestfulModel) async throws {
        guard let transaction = model.transactions.first(where: { $0.description == "Spezi" }) else {
            fatalError("Expected a Transaction with the description \"Spezi\"")
        }
        
        try await model.delete(transaction: transaction.id)
        
        print(
            """
            -------
            Deleted a transaction:
            \(model.transactions)
            """
        )
    }
}
