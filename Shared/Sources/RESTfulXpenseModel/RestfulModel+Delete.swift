//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import XpenseModel


// MARK: RestfulModel + Delete
extension RestfulModel {
    /// Deletes an element from a Restful web service
    /// - Parameters:
    ///   - id: The id of the element that should be deleted
    ///   - keyPath: The `ReferenceWritableKeyPath` that refers to the collection of `Element`s where the `Element` should be deleted from
    /// - Returns: Return async once the resonses from the web service have arrived and have been processed
    func delete<E: Restful>(_ element: E, in keyPath: ReferenceWritableKeyPath<RestfulModel, Set<E>>) async throws {
        do {
            try await E.delete(id: element.id)
            self[keyPath: keyPath].remove(element)
        } catch {
            throw self.setWebServiceError(to: .deleteFailed(E.self))
        }
    }
}
