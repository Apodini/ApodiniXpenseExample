//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - EditTransactionAmountView
/// A view to edit a `Transaction`'s amount and classification
struct EditTransactionAmountView: View {
    /// The `EditTransactionViewModel` that manages the content of the view
    @ObservedObject var viewModel: EditTransactionViewModel
    
    
    /// A `Binding` that is used to translate the output of a `TextField` to a double value according to the `NumberFormatter.decimalAmount` defined
    /// in the XpenseModel Swift Package.
    ///
    /// This is a workaround as using a `NumberFormatter` in the `TextField` does currently not work in our use case.
    var amountString: Binding<String> {
        Binding(get: {
            guard let amount = viewModel.amount else {
                return ""
            }
            return NumberFormatter.decimalAmount.string(from: NSNumber(value: amount)) ?? ""
        }, set: {
            viewModel.amount = NumberFormatter.decimalAmount.number(from: $0)?.doubleValue
        })
    }
    
    var body: some View {
        Section(header: Text("Amount")) {
            HStack {
                HStack(alignment: .center, spacing: 2) {
                    Text("\(viewModel.classification.sign)")
                    // Unfortunately `TextField("Amount", value: $amount, formatter: NumberFormatter.decimalAmount)` does not work at the moment.
                    // While the `TextField` does show the correct value the binding is only updated when the user presses the return key on the
                    // software or hardware keyboard at the moment. As we use the `.decimalPad` keyboard type we can not use this at the moment.
                    TextField("Amount", text: amountString)
                        .keyboardType(.decimalPad) // Show only numbers and a dot
                }
                
                Picker("Transaction Type", selection: $viewModel.classification) {
                    ForEach(XpenseModel.Transaction.Classification.allCases) { transactionType in
                        Text(transactionType.rawValue).tag(transactionType)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}


// MARK: - EditAmount Previews
struct EditAmount_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        Form { // swiftlint:disable:next force_unwrapping
            EditTransactionAmountView(viewModel: EditTransactionViewModel(model, id: model.transactions.first!.id))
        }
    }
}
