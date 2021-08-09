//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: Restful
/// A Restful Element that can be created, read, updated, and deleted from a Restful Web Service
protocol Restful: Codable & Identifiable & Comparable {
    /// The route that should be used to retrieve and store the RESTful Element from the Web Service
    static var route: URL { get }
    
    
    /// Gets the elements from the RESTful Web Service
    static func get() async throws -> [Self]
    
    /// Deletes the element from the Restful Web Service
    static func delete(id: Self.ID) async throws
    
    
    /// Posts the element to the Restful Web Service
    func post() async throws -> Self
    
    /// Puts the element to the Restful Web Service
    func put() async throws -> Self
}


// MARK: Restful
extension Restful where Self.ID == UUID? {
    static func get() async throws -> [Self] {
        try await NetworkManager.getElements(on: Self.route)
    }
    
    
    func post() async throws -> Self {
        try await NetworkManager.postElement(self, on: Self.route)
    }
}


// MARK: Restful + Identifiable UUID
extension Restful where Self.ID == UUID? {
    static func delete(id: Self.ID) async throws {
        try await NetworkManager.delete(at: Self.route.appendingPathComponent(id?.uuidString ?? ""))
    }
    
    func put() async throws -> Self {
        try await NetworkManager.putElement(self, on: Self.route.appendingPathComponent(self.id?.uuidString ?? ""))
    }
}
