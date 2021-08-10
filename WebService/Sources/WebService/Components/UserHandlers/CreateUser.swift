//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import XpenseModel


struct CreateUser: Handler {
    struct CreateUserMediator: Codable {
        let name: String
        let password: String
    }
    
    
    @Environment(\.xpenseModel) var xpenseModel
    
    @Parameter(.http(.body)) var user: CreateUserMediator
    
    @Throws(.badInput, reason: "An Account with the name already exists") var userAlreadyExists: ApodiniError
    
    
    func handle() async throws -> User {
        do {
            return try await xpenseModel.signUp(user.name, password: user.password)
        } catch {
            throw userAlreadyExists
        }
    }
    
    var metadata: Metadata {
        Operation(.create)
    }
}
