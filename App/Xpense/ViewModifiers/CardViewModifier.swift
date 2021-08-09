//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


// MARK: - CardViewModifier
/// A `ViewModifier` to style a `View` with a card style background
struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color("SecondaryBackgroundColor"))
            .cornerRadius(15)
    }
}


// MARK: - View + CardViewModifier
extension View {
    /// Style a `View` with a with card style background
    /// - Returns: A view with the card style background
    func cardViewModifier() -> some View {
        ModifiedContent(content: self, modifier: CardViewModifier())
    }
}
