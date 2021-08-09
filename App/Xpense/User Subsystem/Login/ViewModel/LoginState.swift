//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: LoginState
/// The possible states of the login view
enum LoginState {
    /// The user can login to the Xpense application
    case login
    /// The user can sign of in the Xpense application
    case signUp
    
    
    /// The title of the primary action that is show on the login view
    var primaryActionTitle: String {
        switch self {
        case .login: return "Login"
        case .signUp: return "Create Account"
        }
    }
    
    /// The title of the secondary action that is show on the login view
    var secondaryActionTitle: String {
        switch self {
        case .login: return "Create Account Instead"
        case .signUp: return "Login Instead"
        }
    }
    
    
    /// Toggles the state of the login view between all possible states
    mutating func toggle() {
        switch self {
        case .login: self = .signUp
        case .signUp: self = .login
        }
    }
}
