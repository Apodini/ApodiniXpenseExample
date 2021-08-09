//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - TransactionSummary
/// Displays the information about a `Transaction` including all its information
struct TransactionSummary: View {
    /// The `Model` the   `Transaction` shall be read from
    @EnvironmentObject private var model: Model
    
    /// Indicate whether to disable the navigation link in the Transaction Summary's `Account` detail link
    var disableLink: Bool
    
    /// The `Transaction`'s identifier that should be displayed
    var id: XpenseModel.Transaction.ID
    
    
    var body: some View {
        model.transaction(id).map { transaction in
            VStack {
                Spacer().frame(height: 20)
                VStack(spacing: 4) {
                    Text(transaction.amountDescription)
                        .currencyViewModifier(size: 60, weight: .semibold)
                    
                    Group {
                        Text(transaction.description)
                        Text(transaction.dateDescription)
                    }.foregroundColor(.secondary)
                    
                    AccountDetailLink(disableLink: disableLink, id: transaction.account)
                    
                    transaction.location?.clCoordinate.map { coordinate in
                        LocationDetailLink(coordinate: coordinate,
                                           navigationTitle: transaction.description)
                    }
                }
            }.backgroundViewModifier()
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


// MARK: - TransactionSummary Previews
struct TransactionSummary_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.hashValue) { colorScheme in
            NavigationView {
                TransactionSummary(disableLink: false, id: model.transactions.sorted()[0].id)
            }.colorScheme(colorScheme)
        }.background(Color("BackgroundColor"))
            .environmentObject(model)
    }
}
