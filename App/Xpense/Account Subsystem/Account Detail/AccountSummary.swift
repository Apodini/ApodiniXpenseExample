//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountsSummary
/// An overview of an existing `Account`'s balance and its `Transaction`s.
struct AccountSummary: View {
    /// The `Model` the   `Account` shall be read from
    @EnvironmentObject private var model: Model
    
    /// The `Account`'s identifier
    var id: Account.ID
    
    
    var body: some View {
        VStack {
            AccountBalanceView(id: id)
            TransactionsList(disableLink: true) { transaction in
                transaction.account == self.id
            }
        }.navigationTitle(model.account(id)?.name ?? "")
            .toolbar {
                EditButton()
            }
    }
}

// MARK: - AccountSummary Previews
struct AccountSummary_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    private static var accountId = model.accounts.first!.id // swiftlint:disable:this force_unwrapping
    
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            NavigationView {
                AccountSummary(id: accountId)
            }.colorScheme(colorScheme)
        }.environmentObject(model)
    }
}
