//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


// MARK: - BackgroundViewModifier
/// A `ViewModifier` to style a `View` with a system background color
private struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
            )
    }
}


// MARK: - View + BackgroundViewModifier
extension View {
    /// Style a `View` with a grouped system background color
    /// - Returns: A view with the applied background
    func backgroundViewModifier() -> some View {
        ModifiedContent(content: self, modifier: BackgroundViewModifier())
    }
}
