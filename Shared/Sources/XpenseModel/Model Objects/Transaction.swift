//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: - Transaction
/// Represents a single transaction of an `Account`
public struct Transaction {
    // MARK: - Cent
    /// The base type for all Currencies in the Xpense Application
    public typealias Cent = Int
    
    
    // MARK: - Classification
    /// Classifies `Transactions` into Incomes and Expenses.
    ///
    /// If the amount is greater or equal to the `Transaction` is going to be classified as an `income` otherwise it is an `expense`
    public enum Classification: String, CaseIterable, Identifiable {
        /// An Expense
        case expense = "Expense"
        /// An Income
        case income = "Income"
        
        
        public var id: String {
            self.rawValue
        }
        
        /// The factor that has to be applied to an amount to get the relative value of a `Transaction`
        ///
        /// 1 for an `Classification.income`
        ///
        ///  -1 for an `Classification.expense`
        public var factor: Int {
            self == .income ? 1 : -1
        }
        
        ///  A textual description of the `factor`
        ///
        ///  "" for an `Classification.income`
        ///
        ///  "-" for an `Classification.expense`
        public var sign: String {
            self == .income ? "" : "-"
        }
        
        
        /// Create a new `Classification`
        /// - Parameter amount: The amount of the transaction.
        ///
        /// If the amount is greater or equal to the `Transaction` is going to be classified as an `income` otherwise it is an `expense`
        public init(_ amount: Cent) {
            self = amount < 0 ? .expense : .income
        }
    }
    
    
    /// The stable identity of the entity associated with self
    public var id: UUID?
    /// The amount of money this transaction is worth in `Cent`s
    public var amount: Cent
    /// A textual description of the `Transaction`
    public var description: String
    /// The date this `Transaction` was executed
    public var date: Date
    /// The location of the `Transaction` as a `Coordinate`
    public var location: Coordinate?
    /// The `Account` this `Transaction` is linked to
    public var account: UUID
    
    
    /// This `Transaction`''s classification into expense or income
    public var classification: Classification {
        Classification(amount)
    }
    
    
    /// - Parameters:
    ///     - id: The stable identity of the `Transaction`
    ///     - amount: The amount of money this transaction is worth in `Cent`s
    ///     - description: A textual description of the `Transaction`
    ///     - date: The date this `Transaction` was executed
    ///     - location: The location of the `Transaction` as a `Coordinate`
    ///     - account: The `Account` this `Transaction` is linked to
    public init(id: UUID? = nil,
                amount: Cent,
                description: String,
                date: Date? = nil,
                location: Coordinate? = nil,
                account: UUID) {
        self.id = id
        self.amount = amount
        self.description = description
        self.date = date ?? Date()
        self.location = location
        self.account = account
    }
}


// MARK: Transaction: Identifiable
extension Transaction: Identifiable { }


// MARK: Transaction: Hashable
extension Transaction: Hashable {
    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: Transaction: Comparable
extension Transaction: Comparable {
    public static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.date > rhs.date
    }
}


// MARK: Transaction: LocalFileStorable
extension Transaction: LocalFileStorable { }
