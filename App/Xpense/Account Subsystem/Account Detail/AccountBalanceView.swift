//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountBalanceView
/// A rounded label displaying an `Account`'s balance
struct AccountBalanceView: View {
    /// The `Model` the   `Account` shall be read from
    @EnvironmentObject private var model: Model
    
    /// The `Account`'s identifier
    var id: Account.ID
    
    
    var body: some View {
        Group {
            model.account(id)?.balanceRepresentation(model).map { balance in
                Text(balance)
                    .foregroundColor(.primary)
                    .currencyViewModifier(size: 30, weight: .medium)
                    .padding(12)
                    .colorInvert()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 20))
            }
        }.padding(.horizontal, 16).padding(.vertical, 8)
    }
}


// MARK: - AccountBalanceView Previews
struct AccountBalanceView_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    @State private static var accountId = model.accounts.first!.id // swiftlint:disable:this force_unwrapping
    
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            AccountBalanceView(id: accountId)
                .background(Color.black)
                .colorScheme(colorScheme)
        }.environmentObject(model)
            .previewLayout(.sizeThatFits)
    }
}
