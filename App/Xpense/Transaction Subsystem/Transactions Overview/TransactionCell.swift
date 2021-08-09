//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - TransactionCell
/// A list cell representing a single `Transaction`
struct TransactionCell: View {
    /// The model to read the transactions from
    @EnvironmentObject private var model: Model
    
    /// The `Transaction`'s identifier that should be displayed in the `TransactionCell`
    var id: XpenseModel.Transaction.ID
    
    
    var body: some View {
        model.transaction(id).map { transaction in
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top, spacing: 16) {
                    Text(transaction.description)
                        .font(Font.system(size: 22, weight: .bold))
                    Spacer()
                    Text(transaction.amountDescription)
                        .currencyViewModifier(size: 22,
                                              classification: transaction.classification)
                }
                Text(transaction.relativeDateDescription)
                    .foregroundColor(.secondary)
            }
        }
    }
}


// MARK: - TransactionCell Previews
struct TransactionCell_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.hashValue) { colorScheme in
            TransactionCell(id: model.transactions.first!.id) // swiftlint:disable:this force_unwrapping
                .background(Color("BackgroundColor"))
                .colorScheme(colorScheme)
        }.environmentObject(model)
            .previewLayout(.sizeThatFits)
    }
}
