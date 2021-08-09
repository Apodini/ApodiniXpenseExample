//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniHTTPProtocol
import Foundation


struct Login: Handler {
    @Environment(\.xpenseModel) var xpenseModel
    @Environment(\.connection) var connection
    
    @Throws(.badInput, reason: "The Authentication is no correct basic authentication header") var tokenError: ApodiniError
    @Throws(.unauthenticated, reason: "The credentials provided are not correct") var unauthenticatedError: ApodiniError
    
    
    func handle() async throws -> String {
        guard let (username, password) = connection.information[Authorization.self]?.basic else {
            throw tokenError
        }
        
        do {
            return try await xpenseModel.login(username, password: password)
        } catch {
            throw unauthenticatedError
        }
    }
}
