//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


// MARK: ActiivityButtonStyle
/// A `ButtonStyle` that adds the ability to animate a loading process in the `Button` using a `ProgressView`
struct ProgressViewButtonStyle: ButtonStyle {
    /// The wrapper that is used to e.g. get the `isEnabled` state of the Button
    struct ProgressViewButtonStyleButton: View {
        /// Indicates whether the button is enabled or not
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        /// Indicates whether the button's `ProgressView` should be shown and animating or
        /// if the `label` of the button should be shown
        @Binding var animating: Bool
        
        /// The configuration that is passed to the `ButtonStyle` and handed to the wrapper button
        let configuration: ButtonStyle.Configuration
        /// Defines the color of the `ProgressView`
        let progressViewColor: Color
        /// Defines the color of the button when it is enabled
        let foregroundColor: Color
        
        
        var body: some View {
            if animating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: progressViewColor))
            } else {
                configuration.label
                    .foregroundColor(buttonColor)
            }
        }
        
        /// Defines the button color of the `SaveButtonStyle`
        private var buttonColor: Color {
            if isEnabled {
                return foregroundColor
            } else {
                return Color(.systemGray)
            }
        }
    }
    
    
    /// Indicates whether the button's `ProgressView` should be shown and animating or
    /// if the `label` of the button should be shown
    @Binding var animating: Bool
    
    /// Defines the color of the `ProgressView`
    var progressViewColor: Color = .black
    /// Defines the color of the button when it is enabled
    var foregroundColor: Color = .accentColor
    
    
    /// Returns the appearance and interaction content for a `Button`
    func makeBody(configuration: Self.Configuration) -> some View {
        ProgressViewButtonStyleButton(animating: $animating,
                                      configuration: configuration,
                                      progressViewColor: progressViewColor,
                                      foregroundColor: foregroundColor)
    }
}
