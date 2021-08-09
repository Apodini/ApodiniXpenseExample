//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


// MARK: LoginTextFieldStyle
/// A `TextFieldStyle` that adds styles the textfiled with a `secondarySystemBackground` colored background
/// and a small border around the text
struct LoginTextFieldStyle: TextFieldStyle {
    // swiftlint:disable:next identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textContentType(.password)
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("BackgroundColor").opacity(0.6))
            )
    }
}
