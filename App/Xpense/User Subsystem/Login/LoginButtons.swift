//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - LoginButtons
/// The buttons that display the primary and secondary buttons for the login screen
struct LoginButtons: View {
    /// The `LoginViewModel` that manages the content of the login screen
    @ObservedObject var viewModel: LoginViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: viewModel.primaryAction) {
                Text(viewModel.state.primaryActionTitle)
            }.buttonStyle(PrimaryButtonStyle(animating: $viewModel.loadingInProcess))
                .disabled(!viewModel.enablePrimaryButton)
            Spacer()
                .frame(height: 16)
            Button(action: viewModel.secondaryAction) {
                Text(viewModel.state.secondaryActionTitle)
            }
        }
    }
}


// MARK: - LoginButtons Previews
struct LoginButtons_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtons(viewModel: LoginViewModel(MockModel()))
    }
}
