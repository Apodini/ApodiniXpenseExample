//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


/// The view model used for the `SaveButton`
protocol SaveButtonViewModel: ObservableObject {
    /// Indicates if the save button should be disabled
    var disableSaveButton: Bool { get }
    /// Indicates if the save button progress indicator should be shown
    var showSaveProgressView: Bool { get set }
    
    
    /// The action that should be performed by the save button
    func save() async throws
}


// MARK: - SaveButton
/// Button that is used to save the edits made to a model conforming to `SaveButtonViewModel`
struct SaveButton<M: SaveButtonViewModel>: View {
    /// The `SaveButtonViewModel` that manages the content of the view
    @ObservedObject var viewModel: M
    
    /// Callback that is used to notify about the success of saving the element in the viewModel
    @State var onSuccess: (() -> Void)?


    var body: some View {
        Button(action: save) {
            Text("Save")
                .bold()
        }.disabled(viewModel.disableSaveButton)
            .buttonStyle(ProgressViewButtonStyle(animating: $viewModel.showSaveProgressView))
    }


    /// Saves the element using the view model
    private func save() {
        Task {
            try await viewModel.save()
            
            DispatchQueue.main.async {
                onSuccess?()
            }
        }
    }
}
