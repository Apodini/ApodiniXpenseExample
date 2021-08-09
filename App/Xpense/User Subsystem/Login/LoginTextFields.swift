//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - LoginTextFields
/// The view that displays the `TextField` for the login screen
struct LoginTextFields: View {
    /// The `LoginViewModel` that manages the content of the login screen
    @ObservedObject var viewModel: LoginViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(LoginTextFieldStyle())
            Spacer()
                .frame(height: 8)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(LoginTextFieldStyle())
            if viewModel.state == .signUp {
                Spacer()
                    .frame(height: 8)
                SecureField("Repeat Password", text: $viewModel.passwordAgain)
                    .textFieldStyle(LoginTextFieldStyle())
            }
        }
    }
}


// MARK: - LoginTextFields Previews
struct LoginTextFields_Previews: PreviewProvider {
    static var previews: some View {
        LoginTextFields(viewModel: LoginViewModel(MockModel()))
    }
}
