//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - LoginView
/// The view that displays login screen of the Xpense App
struct LoginView: View {
    /// The `LoginViewModel` that manages the content of the login screen
    @ObservedObject var viewModel: LoginViewModel
    
    /// Used to indicate if the text input views and the login button should be shown
    @State var showViews = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            WelcomeToXpenseView()
            if showViews {
                VStack(spacing: 0) {
                    LoginTextFields(viewModel: viewModel)
                    Spacer()
                        .frame(height: 24)
                    LoginButtons(viewModel: viewModel)
                    Spacer()
                        .frame(height: 0)
                }.padding()
                    .frame(maxWidth: 450)
                    .transition(.opacity)
            }
        }.onAppear(perform: onAppear)
    }
    
    
    /// - Parameter model: The `Model` that is used to manage the `User` of the Xpense Application
    init(_ model: Model) {
        viewModel = LoginViewModel(model)
    }
    
    
    /// Starts the appear `Animation` of the `LoginView`
    func onAppear() {
        let animation = Animation
            .easeInOut(duration: 0.5)
            .delay(1)
        
        withAnimation(animation) {
            self.showViews = true
        }
    }
}


// MARK: - LoginView Previews
struct LoginView_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ZStack {
                Color("BackgroundColor")
                LoginView(model)
            }.colorScheme(colorScheme)
        }.environmentObject(model)
            .previewLayout(.fixed(width: 600, height: 900))
    }
}
