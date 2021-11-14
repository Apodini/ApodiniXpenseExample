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


// MARK: EditAccountViewModel
class EditAccountViewModel: ObservableObject {
    /// The `Account`'s name
    @Published var name: String = ""
    /// Indicates whether the deletion alert should be displayed
    @Published var showDeleteAlert = false
    /// Indicates whether the save button should show a Progress Indicator
    @Published var showSaveProgressView = false
    /// Indicates whether the delete button should show a Progress Indicator
    @Published var showDeleteProgressView = false
    
    /// The `Account`'s identifier that should be edited
    var id: XpenseModel.Account.ID
    /// The `Model` that is used to interact with the `Account`s of the Xpense application
    private weak var model: Model?
    
    
    /// The Accounts of the Xpense App loaded from the `Model`
    var accounts: [Account] {
        model?.accounts.sorted() ?? []
    }
    /// Indicates if the save `Button` should be disabled
    var disableSaveButton: Bool {
        showSaveProgressView || showDeleteProgressView
    }
    
    
    /// - Parameter model: The `Model` that is used to interact with the `Account`s of the Xpense application
    /// - Parameter id: The `Account`'s identifier that should be edited
    init(_ model: Model, id: XpenseModel.Account.ID) {
        self.model = model
        self.id = id
    }
    
    
    @MainActor
    private func showDeleteProgressView(_ showDeleteProgressView: Bool) {
        self.showDeleteProgressView = showDeleteProgressView
    }
    
    /// Updates the `EditViews`'s state like the name based on the `id`
    @MainActor
    func updateStates() {
        guard let account = model?.account(id) else {
            self.name = ""
            return
        }
        
        self.name = account.name
    }
    
    /// Saves the `Account` that is currently edited
    func save() async throws {
        guard let model = model, let userId = model.user?.id else {
            throw XpenseServiceError.saveFailed(Account.self)
        }
        
        let account = Account(id: self.id, name: self.name, userID: userId)
        
        await showDeleteProgressView(true)
        
        try await model.save(account)
        
        await self.updateStates()
        await showDeleteProgressView(false)
    }
    
    /// Deletes the `Account` that is currently edited
    func delete() async throws {
        guard let id = id, let model = model else {
            throw XpenseServiceError.deleteFailed(Account.self)
        }
        
        await showDeleteProgressView(true)
        
        try await model.delete(account: id)
        
        await self.updateStates()
        await showDeleteProgressView(false)
    }
}


// MARK: EditAccountViewModel + ErrorViewModel
extension EditAccountViewModel: ErrorViewModel {
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


// MARK: EditAccountViewModel + SaveButtonViewModel
extension EditAccountViewModel: SaveButtonViewModel {}
