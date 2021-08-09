//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel
import CoreLocation


// MARK: - EditTransaction
/// A view that enables the user to edit a `Transaction`
struct EditTransaction: View {
    /// Indicates whether this `EditAccount` view is currently presented
    @Environment(\.presentationMode) private var presentationMode
    /// The `EditTransactionViewModel` that manages the content of the view
    @ObservedObject private var viewModel: EditTransactionViewModel
    
    
    /// The title in the navigation bar for this view
    var navigationTitle: String {
        viewModel.id == nil ? "Create Transaction" : "Edit Transaction"
    }
    
    
    /// - Parameter model: The `Model` that is used to manage the `Transaction`s of the Xpense Application
    /// - Parameter id: The `Transaction`'s identifier that should be edited
    init(_ model: Model, id: XpenseModel.Transaction.ID) {
        viewModel = EditTransactionViewModel(model, id: id)
    }
    
    
    var body: some View {
        NavigationView {
            self.form
                .onAppear(perform: viewModel.updateStates)
                .navigationBarTitle(navigationTitle, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        SaveButton(viewModel: viewModel) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .alert(isPresented: viewModel.presentingErrorMessage) {
                    Alert(title: Text("Error"),
                          message: Text(viewModel.errorMessage ?? ""))
                }
        }.navigationViewStyle(StackNavigationViewStyle())
            .disabled(viewModel.showSaveProgressView)
    }
    
    /// The `From` component of the `EditTransaction` view
    private var form: some View {
        Form {
            EditTransactionAmountView(viewModel: viewModel)
            
            Section(header: Text("Description")) {
                TextField("Description", text: $viewModel.description)
            }
            
            Section(header: Text("Account")) {
                Picker("Account", selection: $viewModel.selectedAccount) {
                    ForEach(viewModel.accounts) { account in
                        Text(account.name).tag(account.id)
                    }
                }
            }
            
            Section(header: Text("Date")) {
                DatePicker(selection: $viewModel.date,
                           in: ...Date(),
                           displayedComponents: [.date, .hourAndMinute]) {
                    Text("Date")
                }
            }
            
            EditTransactionLocation(viewModel: viewModel)
        }
    }
}


// MARK: - EditTransaction Previews
struct EditTransaction_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        EditTransaction(model, id: model.transactions.first!.id) // swiftlint:disable:this force_unwrapping
            .environmentObject(model)
    }
}
