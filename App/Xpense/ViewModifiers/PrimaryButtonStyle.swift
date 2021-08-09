//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


// MARK: PrimaryButtonStyle
/// A `ButtonStyle` that adds a prominent backgrond as well as the ability to animate a loading process
/// in the `Button` using a `ProgressView`
struct PrimaryButtonStyle: ButtonStyle {
    /// The wrapper that is used to e.g. get the `isEnabled` state of the Button
    struct PrimaryButtonStyleButton: View {
        /// Indicates whether the button is enabled or not
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        /// Indicates whether the button's `ProgressView` should be shown and animating or
        /// if the `label` of the button should be shown
        @Binding var animating: Bool
        
        /// The configuration that is passed to the `ButtonStyle` and handed to the wrapper button
        let configuration: ButtonStyle.Configuration
        
        
        var body: some View {
            HStack {
                Spacer()
                if animating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(2)
                } else {
                    configuration.label
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                Spacer()
            }.padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(backgroundColor)
                )
        }
        
        /// Defines the background color of the `PrimaryButtonStyle`
        private var backgroundColor: Color {
            if isEnabled {
                return .accentColor
            } else {
                return Color("FormPlaceholder")
            }
        }
    }
    
    
    /// Indicates whether the button's `ProgressView` should be shown and animating or
    /// if the `label` of the button should be shown
    @Binding var animating: Bool
    
    
    /// Returns the appearance and interaction content for a `Button`
    func makeBody(configuration: Self.Configuration) -> some View {
        PrimaryButtonStyleButton(animating: $animating, configuration: configuration)
    }
}
