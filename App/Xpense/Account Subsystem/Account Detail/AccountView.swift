//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountsView
/// Detail view for a single `Account` including all its transactions
struct AccountView: View {
    /// The `Model` the   `Account` shall be read from
    @EnvironmentObject private var model: Model
    
    /// Indicates whether the edit account sheet is supposed to be presented
    @State private var edit = false
    
    /// The `Account`'s identifier that should be displayed
    var id: Account.ID
    
    
    var body: some View {
        AccountSummary(id: id)
            .sheet(isPresented: $edit) {
                EditAccount(model, id: self.id)
            }
            .toolbar {
                Button(action: { self.edit = true }) {
                    Text("Edit")
                }
            }
    }
}


// MARK: - AccountView Previews
struct AccountView_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        NavigationView {
            AccountView(id: model.accounts.first!.id) // swiftlint:disable:this force_unwrapping
        }.environmentObject(model)
    }
}
