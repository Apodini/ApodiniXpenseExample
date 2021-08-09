//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


// MARK: - AccountBackground
/// The background of an Account view drawing a rounded rectangle including a shaddow
struct AccountBackground: View {
    /// The current system `ColorScheme`
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color("SecondaryBackgroundColor"))
            .shadow(radius: 3)
    }
}


// MARK: - AccountBackground
struct AccountBackground_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountBackground()
            AccountBackground()
                .preferredColorScheme(.dark)
        }.padding()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
