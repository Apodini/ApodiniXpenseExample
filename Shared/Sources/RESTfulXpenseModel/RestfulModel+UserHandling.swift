//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import XpenseModel


// MARK: RestfulModel + User Handling
extension RestfulModel {
    /// Sends a sign in request to the Xpense Web Service and parses the corresponding response and updates the `Model`
    /// - Parameters:
    ///   - name: The name that should be used to sign in
    ///   - password: The password that should be used to sign in
    /// - Returns: An `AnyPublisher` that finishes once the sign in resonse arrived and the response was handled
    func sendSignUpRequest(_ name: String, password: String) async throws -> User {
        do {
            let usersRoute = RestfulModel.baseURL.appendingPathComponent("users")
            let signUpMediator = try await NetworkManager.postElement(
                SignUpMediator(name: name, password: password),
                on: usersRoute
            )
            
            return try await self.sendLoginRequest(signUpMediator.name, password: password)
        } catch {
            throw self.setWebServiceError(to: XpenseServiceError.signUpFailed)
        }
    }

    
    /// Sends a login request to the Xpense Web Service and parses the corresponding response and updates the `Model`
    /// - Parameters:
    ///   - name: The name that should be used to login
    ///   - password: The password that should be used to login
    /// - Returns: An `AnyPublisher` that finishes once the login resonse arrived and the response was handled
    @discardableResult
    func sendLoginRequest(_ name: String, password: String) async throws -> User {
        guard let basicAuthToken = "\(name):\(password)".data(using: .utf8)?.base64EncodedString() else {
            throw XpenseServiceError.loginFailed
        }

        do {
            let token = try await NetworkManager.postElement(
                String(),
                authorization: "Basic \(basicAuthToken)",
                on: RestfulModel.baseURL.appendingPathComponent("login")
            )
            
            return User(name: name, token: token)
        } catch {
            throw self.setWebServiceError(to: XpenseServiceError.loginFailed)
        }
    }
}
