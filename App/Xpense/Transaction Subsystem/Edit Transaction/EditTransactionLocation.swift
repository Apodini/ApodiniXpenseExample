//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - EditTransactionLocation
struct EditTransactionLocation: View {
    /// The `EditTransactionViewModel` that manages the content of the view
    @ObservedObject var viewModel: EditTransactionViewModel
    
    
    var body: some View {
        Section(header: Text("Location")) {
            HStack {
                if let location = viewModel.location {
                    LocationView(coordinate: location)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(3.0)
                } else {
                    Text("Select a location ...")
                        .foregroundColor(Color("FormPlaceholder"))
                }
            }
                .onTapGesture {
                    viewModel.showLocationSlectionView = true
                }
                .sheet(isPresented: $viewModel.showLocationSlectionView) {
                    EditLocationView(coordinate: $viewModel.location)
                }
        }
    }
}


// MARK: - EditTransactionLocation Previews
struct EditTransactionLocation_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View { // swiftlint:disable:next force_unwrapping
        EditTransactionLocation(viewModel: EditTransactionViewModel(model, id: model.transactions.first!.id))
            .environmentObject(model)
    }
}
