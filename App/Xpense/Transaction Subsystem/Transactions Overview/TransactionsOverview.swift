//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - TransactionsOverview
/// View displaying all `Transactions` regardless of the account they belong to
struct TransactionsOverview: View {
    /// The `Model` the   `Transaction`s shall be read from
    @EnvironmentObject private var model: Model
    
    /// Indicates whether the add transaction sheet is supposed to be presented
    @State private var presentAddTransaction = false
    /// Indicates whether the alert asking to confirm the logout process should be displayed
    @State private var presentUserAlert = false
    
    
    var body: some View {
        NavigationView {
            TransactionsList(disableLink: false)
                .navigationTitle("Transactions")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        UserButton(presentUserAlert: $presentUserAlert)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        addButton
                    }
                }
                .alert(isPresented: $presentUserAlert) {
                    UserButton.createLogoutAlert(model)
                }
                .sheet(isPresented: $presentAddTransaction) {
                    EditTransaction(self.model, id: nil)
                }
            // To support the `DoubleColumnNavigationViewStyle` we are providing a default view that displays the first `Transaction` in the Xpense app
            // The current SwiftUI behaviour is to hide the list on the iPad in portrait mode.
            TransactionView(disableLink: false, id: model.transactions.first?.id)
        }
    }
    
    /// Button that is used to add a new `Transaction`
    private var addButton: some View {
        Button(action: { self.presentAddTransaction = true }) {
            Image(systemName: "plus")
        }
    }
}


// MARK: - TransactionsOverview Previews
struct TransactionsOverview_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsOverview()
            .environmentObject(MockModel() as Model)
    }
}
