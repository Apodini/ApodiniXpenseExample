//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - TransactionView
/// Detail view for a single `Transaction` including all its information
struct TransactionView: View {
    /// The `Model` the   `Transaction` shall be read from
    @EnvironmentObject private var model: Model
    
    /// Indicate whether to disable the navigation link in the Transaction Summary's `Account` detail link
    var disableLink: Bool
    
    /// Indicates whether the edit transaction sheet is supposed to be presented
    @State private var edit = false
    
    /// The `Transaction`'s identifier that should be displayed
    var id: XpenseModel.Transaction.ID
    
    
    var body: some View {
        TransactionSummary(disableLink: disableLink, id: id)
            .sheet(isPresented: $edit) {
                EditTransaction(self.model, id: self.id)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { self.edit = true }) {
                        Text("Edit")
                    }.disabled(model.transactions.isEmpty)
                }
            }
    }
}


// MARK: - TransactionView Previews
struct TransactionView_Previews: PreviewProvider {
    private static let mock: Model = MockModel()
    
    
    static var previews: some View {
        NavigationView {
            TransactionView(disableLink: false, id: mock.transactions.first!.id) // swiftlint:disable:this force_unwrapping
        }.environmentObject(mock)
    }
}
