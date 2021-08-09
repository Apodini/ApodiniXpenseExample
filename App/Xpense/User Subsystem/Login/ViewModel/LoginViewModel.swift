//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import Combine
import XpenseModel


// MARK: LoginViewModel
class LoginViewModel: ObservableObject {
    /// The Constants that are used to define the behaviour of the `LoginViewModel`
    enum Constants {
        /// The minimal password length that is enforced by the `LoginViewModel`
        static let minimalPasswordLength = 8
    }
    
    
    // State
    /// The current state of the login view defined by the `LoginState`
    @Published var state: LoginState = .login
    // Input
    /// The current username that is typed in the login view
    @Published var username: String = ""
    /// The current password that is typed in the login view
    @Published var password: String = ""
    /// The current password that is typed in the second `Textfield` in the login view
    @Published var passwordAgain: String = ""
    //Output
    /// Indicates whether the primary `Button` of the login view sould be enabled
    @Published var enablePrimaryButton = true
    /// Indicates whether the Model is currently loading data
    @Published var loadingInProcess = false
    
    /// The `AnyCancellable`s that is used to keep a reference to the publisher chains used in the `LoginViewModel`
    private var cancellables: Set<AnyCancellable> = []
    /// The `Model` that is used to interact with the `User` of the Xpense application
    private weak var model: Model?
    
    
    /// Indicates whether the current typed in password is valid according to the rules defined in the `LoginViewModel`
    var validPassword: AnyPublisher<String?, Never> {
        $password
            .map { password in
                guard password.count >= Constants.minimalPasswordLength else {
                    return nil
                }
                return password
            }
            .eraseToAnyPublisher()
    }
    
    /// Indicates whether the current typed in password and the password that is typed in the second `Textfield` in
    /// the login view is are the same and valid according to the rules defined in the `LoginViewModel`
    var validatedSignUpPassword: AnyPublisher<String?, Never> {
        validPassword
            .combineLatest($passwordAgain) { validPassword, passwordAgain in
                guard validPassword == passwordAgain else {
                    return nil
                }
                return validPassword
            }
            .eraseToAnyPublisher()
    }

    /// Calculates whether the primary `Button` of the login view sould be enabled
    var calculateEnablePrimaryButton: AnyPublisher<Bool, Never> {
        $username
            .map(\.isEmpty)
            .combineLatest(validPassword) { !$0 && $1 != nil }
            .combineLatest(validatedSignUpPassword, $state)
            .map { missingData, validatedPassword, state in
                switch state {
                case .login:
                    return missingData
                case .signUp:
                    return missingData && validatedPassword != nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    /// - Parameter model: The `Model` that is used to interact with the `User` of the Xpense application
    init(_ model: Model) {
        self.model = model
        calculateEnablePrimaryButton
            .assign(to: \.enablePrimaryButton, on: self)
            .store(in: &cancellables)
    }
    
    
    /// The primary action of the login view. The performed action is dependet on the current state of the
    /// login view defined by the `LoginState`
    func primaryAction() {
        loadingInProcess = true
        
        Task {
            switch state {
            case .login:
                try await model?.login(username, password: password)
            case .signUp:
                try await model?.signUp(username, password: password)
            }
            
            DispatchQueue.main.async {
                self.loadingInProcess = false
            }
        }
    }
    
    /// The secondary action of the login view. The performed action is dependet on the current state of the
    /// login view defined by the `LoginState`
    func secondaryAction() {
        withAnimation(.easeInOut(duration: 0.2)) {
            state.toggle()
        }
    }
}
