//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: RestfulModel + Save
extension RestfulModel {
    /// Saves an `Restful` element to a RESTful Web Service
    /// - Parameters:
    ///   - element: The `Restful` element that should be saved
    ///   - collection: The collection where the element should be saved in once a response has arrived
    /// - Returns: Completes async once the responses from the web service have arrived and have been processed
    func saveElement<T: Restful>(_ element: T, to collection: ReferenceWritableKeyPath<RestfulModel, Set<T>>) async throws -> T {
        do {
            let newElement: T
            if self[keyPath: collection].contains(where: { $0.id == element.id }) {
                newElement = try await element.put()
            } else {
                newElement = try await element.post()
            }
            self[keyPath: collection].update(with: newElement)
            return newElement
        } catch {
            throw self.setWebServiceError(to: .saveFailed(T.self))
        }
    }
}
