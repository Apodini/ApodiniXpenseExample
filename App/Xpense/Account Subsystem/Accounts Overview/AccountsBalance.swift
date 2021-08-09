//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountsBalance
/// Shows the combined balance of all `Account`s the Xpense Application
struct AccountsBalance: View {
    /// The `Model` the   `Account`s shall be read from
    @EnvironmentObject private var model: Model
    /// The current system `ColorScheme`
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(NumberFormatter.currencyRepresentation(from: model.currentBalance) ?? "")
                    .currencyViewModifier(size: 30, weight: .bold)
                Text("Current Total Balance")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }.padding(16)
            .background(AccountBackground())
            .padding(.horizontal, 16)
    }
}


// MARK: - AccountsBalance Previews
struct AccountsBalance_Previews: PreviewProvider {
    static var previews: some View {
        AccountsBalance()
            .environmentObject(MockModel() as Model)
    }
}
