//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import CoreLocation
import XpenseModel
import SwiftUI


// MARK: EditTransactionViewModel
class EditTransactionViewModel: ObservableObject {
    /// The `Transaction`'s amount, the default amount is 0
    @Published var amount: Double?
    /// The `Transaction`'s classification
    @Published var classification: XpenseModel.Transaction.Classification = .income
    /// The `Transaction`'s description
    @Published var description: String = ""
    /// The `Transaction`'s date and time, the default value is the current date and time
    @Published var date = Date()
    /// The `Transaction`'s location
    @Published var location: CLLocationCoordinate2D?
    /// The `Transaction`'s `Account`
    @Published var selectedAccount: XpenseModel.Account.ID = nil
    /// Indicates whether the transaction was already loaded based on the injected `model` property
    @Published var loaded = false
    /// Indicates whether the save button should show a Progress Indicator
    @Published var showLocationSlectionView = false
    /// Indicates whether the save button should show a Progress Indicator
    @Published var showSaveProgressView = false
    
    /// The `Transaction`'s identifier that should be edited
    var id: XpenseModel.Transaction.ID
    /// The `Model` that is used to interact with the `Transaction`s of the Xpense application
    private weak var model: Model?
    
    
    /// The Accounts of the Xpense App loaded from the `Model`
    var accounts: [Account] {
        model?.accounts.sorted() ?? []
    }
    /// Indicates if the save `Button` should be disabled
    var disableSaveButton: Bool {
        selectedAccount == nil || description.isEmpty || amount == nil || location == nil
    }
    
    
    /// - Parameter model: The `Model` that is used to interact with the `Transaction`s of the Xpense application
    /// - Parameter id: The `Transaction`'s identifier that should be edited
    init(_ model: Model, id: XpenseModel.Transaction.ID) {
        self.model = model
        self.id = id
    }
    
    
    @MainActor
    private func showSaveProgressView(_ showSaveProgressView: Bool) {
        self.showSaveProgressView = showSaveProgressView
    }
    
    /// Updates the `EditTransaction`'s state like the name based on the `id`
    @MainActor
    func updateStates() {
        guard let transaction = model?.transaction(id), !loaded else {
            return
        }
        
        // Fill attributes from existing transaction
        self.amount = Double(abs(transaction.amount))
        self.classification = transaction.classification
        self.description = transaction.description
        self.date = transaction.date
        self.location = transaction.location?.clCoordinate
        self.selectedAccount = transaction.account
        
        // Indicate that the content has been loaded to we don't reset properties if
        // we e.g. navigate into a child view using `NavigationLink`s
        self.loaded = true
    }
    
    /// Saves the `Transaction` that is currently edited
    func save() async throws {
        guard let amount = amount,
              let selectedAccount = selectedAccount,
              let location = location,
              let model = model else {
            throw XpenseServiceError.saveFailed(Transaction.self)
        }
        
        let transaction = Transaction(id: self.id,
                                      amount: Transaction.Cent(amount) * classification.factor,
                                      description: self.description,
                                      date: self.date,
                                      location: Coordinate(location),
                                      account: selectedAccount)
        
        await showSaveProgressView(true)
        
        try await model.save(transaction)
        
        await self.updateStates()
        await showSaveProgressView(false)
    }
}


// MARK: EditTransactionViewModel + ErrorViewModel
extension EditTransactionViewModel: ErrorViewModel {
    var errorMessage: String? {
        self.model?.errorMessage
    }
    
    var presentingErrorMessage: Binding<Bool> {
        Binding(get: {
            self.model?.presentingErrorMessage.wrappedValue ?? false
        }, set: { newValue in
            self.model?.presentingErrorMessage.wrappedValue = newValue
        })
    }
}


// MARK: EditTransactionViewModel + SaveButtonViewModel
extension EditTransactionViewModel: SaveButtonViewModel {}
