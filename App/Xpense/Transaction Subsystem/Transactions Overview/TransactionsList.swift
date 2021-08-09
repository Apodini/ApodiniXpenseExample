//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel

 
// MARK: - TransactionsList
/// A list of all `Transaction`s in the Xpense Application with an option to filter the `Transaction`s using the `filter` property
struct TransactionsList: View {
    /// The model to read the transactions from
    @EnvironmentObject private var model: Model
    
    /// Indicate whether to disable the navigation link in the Transaction Summary's `Account` detail link
    var disableLink: Bool
    
    /// A filter function that is used to filter the `Transaction`s in the Xpense Application that should be displayed in the `TransactionsList`
    var filter: (XpenseModel.Transaction) -> Bool = { _ in true }
    
    
    /// The Transaction that are displayed in the TransactionsList
    private var transactions: [XpenseModel.Transaction] {
        model.transactions.filter(filter)
    }
    
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                NavigationLink(destination: TransactionView(disableLink: disableLink, id: transaction.id)) {
                    TransactionCell(id: transaction.id)
                }
            }.onDelete(perform: delete(at:))
        }
    }
    
    
    /// Deletes the Transaction at the given index set in the TransactionsList
    /// - Parameters:
    ///     - indexSet: The index set of the View in the `TransactionsList` that should be deleted
    private func delete(at indexSet: IndexSet) {
        for index in indexSet.map({ transactions[$0].id }) {
            Task {
                try await self.model.delete(transaction: index)
            }
        }
    }
}


// MARK: - TransactionsList Previews
struct TransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionsList(disableLink: true)
                .navigationTitle("Transactions")
        }.environmentObject(MockModel() as Model)
    }
}
