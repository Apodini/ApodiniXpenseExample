//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountsOverview
/// An overview of all `Account`s the Xpense Application
struct AccountsOverview: View {
    /// The `Model` the   `Account`s shall be read from
    @EnvironmentObject private var model: Model
    
    /// Indicates whether the add account sheet is supposed to be presented
    @State private var presentAddAccount = false
    /// Indicates whether the alert asking to confirm the logout process should be displayed
    @State private var presentUserAlert = false
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                AccountsBalance()
                    .padding(.bottom, 8)
                AccountsGrid()
                    .padding(.bottom, 16)
            }.backgroundViewModifier()
                .navigationTitle("Accounts")
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
                .sheet(isPresented: $presentAddAccount) {
                    EditAccount(model, id: nil)
                }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    /// Button that is used to add a new `Account`
    private var addButton: some View {
        Button(action: { self.presentAddAccount = true }) {
            Image(systemName: "plus")
        }
    }
}


// MARK: - AccountsView Previews
struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsOverview()
            .environmentObject(MockModel() as Model)
    }
}
