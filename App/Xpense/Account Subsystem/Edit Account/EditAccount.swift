//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - EditAccount
/// A view that enables the user to edit an `Account`
struct EditAccount: View {
    /// Indicates whether this `EditAccount` view is currently presented
    @Environment(\.presentationMode) private var presentationMode
    
    /// The `EditAccountViewModel` that manages the content of the view
    @ObservedObject private var viewModel: EditAccountViewModel
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Account Name", text: $viewModel.name)
                }
                if viewModel.id != nil {
                    DeleteButton(viewModel: viewModel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }.onAppear(perform: viewModel.updateStates)
                .navigationTitle(viewModel.id == nil ? "Add Account" : "Edit Account")
                .toolbar {
                    SaveButton(viewModel: viewModel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                        .alert(isPresented: viewModel.presentingErrorMessage) {
                            Alert(title: Text("Error"),
                                  message: Text(viewModel.errorMessage ?? ""))
                        }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    /// - Parameter model: The `Model` that is used to manage the `Account`s of the Xpense Application
    /// - Parameter id: The `Account`'s identifier that should be edited
    init(_ model: Model, id: XpenseModel.Transaction.ID) {
        viewModel = EditAccountViewModel(model, id: id)
    }
}


// MARK: - DeleteButton
/// A button that deletes an `Account` used in the `EditAccount` view
private struct DeleteButton: View {
    /// The `EditAccountViewModel` that manages the content of the view
    @ObservedObject var viewModel: EditAccountViewModel
    
    /// Callback that is used to notify about the success of deleting the `Account`
    @State var onSuccess: (() -> Void)?
    
    
    var body: some View {
        Button(action: { viewModel.showDeleteAlert = true }) {
            HStack {
                Spacer()
                Text("Delete")
                Spacer()
            }
        }.buttonStyle(ProgressViewButtonStyle(animating: $viewModel.showDeleteProgressView,
                                              progressViewColor: .gray,
                                              foregroundColor: .red))
            .alert(isPresented: $viewModel.showDeleteAlert) {
                deleteAlert
            }
    }
    
    /// Alter that is used to verify that the user really wants to delete the `Account`
    private var deleteAlert: Alert {
        Alert(title: Text("Delete Account"),
              message: Text("If you delete the Account you will also delete all Transactions associated with the Account"),
              primaryButton: .destructive(Text("Delete"), action: delete),
              secondaryButton: .cancel())
    }
    
    
    /// Uses the `EditAccountViewModel` to delete the account
    private func delete() {
        Task {
            try await viewModel.delete()
            
            DispatchQueue.main.async {
                onSuccess?()
            }
        }
    }
}


// MARK: - EditAccount Previews
struct EditAccount_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        EditAccount(model, id: model.accounts.first!.id) // swiftlint:disable:this force_unwrapping
            .environmentObject(model)
    }
}
