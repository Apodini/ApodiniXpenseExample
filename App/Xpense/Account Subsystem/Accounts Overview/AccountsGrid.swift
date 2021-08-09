//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountsGrid
struct AccountsGrid: View {
    /// The `Model` the   `Account`s shall be read from
    @EnvironmentObject private var model: Model
    
    /// Indicates whether the add account sheet is supposed to be presented
    @State private var selectedAccount: Account.ID = nil
    
    /// The columns of the `LazyVGrid` that enable a dynamic layout for differet device sizes
    let columns = [
        GridItem(.adaptive(minimum: 140), spacing: 16)
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(model.accounts.sorted()) { account in
                NavigationLink(destination: AccountView(id: account.id)) {
                    ZStack {
                        AccountBackground()
                            .frame(height: 140)
                        VStack(spacing: 4) {
                            Text(account.name)
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.primary)
                            Text(NumberFormatter.currencyRepresentation(from: account.balance(model)) ?? "")
                                .font(.system(size: 18, weight: .light))
                                .foregroundColor(.secondary)
                        }.padding()
                    }
                }
            }
        }.padding(.horizontal, 16)
    }
}


// MARK: - AccountsGrid Previews
struct AccountsGrid_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AccountsGrid()
                    .navigationTitle("Accounts")
            }
            NavigationView {
                AccountsGrid()
                    .navigationTitle("Accounts")
                    .preferredColorScheme(.dark)
            }
        }.environmentObject(MockModel() as Model)
    }
}
