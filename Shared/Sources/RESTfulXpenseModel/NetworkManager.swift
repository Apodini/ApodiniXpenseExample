//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif


// MARK: NetworkManager
/// A `NetworkManager` handles the HTTP based network Requests to a web service
enum NetworkManager {
    struct DataWrapper<D: Decodable>: Decodable {
        enum CodingKeys: String, CodingKey {
            case data
            case links = "_links"
        }
        
        let data: D
        let links: [String: String]
    }
    
    
    /// The default `Authorization` header field for requests made by the `NetworkManager`
    static var authorization: String?
    
    /// The `JSONEncoder` that is used to encode request bodies to JSON
    static var encoder = JSONEncoder()
    
    /// The `JSONDecoder` that is used to decode response bodies to JSON
    static var decoder = JSONDecoder()
    
    
    /// Creates a `URLRequest` based on the parameters that has the `Content-Type` header field set to `application/json`
    /// - Parameters:
    ///   - method: The HTTP method
    ///   - url: The `URL` of the `URLRequest`
    ///   - authorization: The value that should be added the `Authorization` header field
    ///   - body: The HTTP body that should be added to the `URLRequest`
    /// - Returns: The created `URLRequest`
    private static func urlRequest(
        _ method: String,
        url: URL,
        authorization: String? = authorization,
        body: Data? = nil
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let authorization = authorization {
            urlRequest.addValue(authorization, forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    /// Executes a `URLRequest` and checks and decodes the response
    /// - Returns: The decoded response
    private static func execute<Element: Decodable>(_ urlRequest: URLRequest) async throws -> Element {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, 200..<299 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(DataWrapper<Element>.self, from: data).data
    }
    
    
    /// Gets a single `Element` from a `URL` specified by `route`
    /// - Parameters:
    ///     - route: The route to get the `Element` from
    ///     - authorization: The `String` that should written in the `Authorization` header field
    /// - Returns: An `AnyPublisher` that contains the `Element` from the web service or or an `Error` in the case of an error
    static func getElement<Element: Decodable>(
        on route: URL,
        authorization: String? = authorization
    ) async throws -> Element {
        try await execute(urlRequest("GET", url: route, authorization: authorization))
    }
    
    /// Gets a list of `Element`s from a `URL` specified by `route`
    /// - Parameters:
    ///     - route: The route to get the `Element`s from
    ///     - authorization: The `String` that should written in the `Authorization` header field
    /// - Returns: An `Array` of  `Element` from the web service or an empty `Array` in the case of an error
    static func getElements<Element: Decodable>(
        on route: URL,
        authorization: String? = authorization
    ) async throws -> [Element] {
        try await getElement(on: route, authorization: authorization)
    }
    
    /// Creates an `Element`s to a `URL` specified by `route`
    /// - Parameters:
    ///     - element: The `Element` that should be created
    ///     - route: The route to get the `Element`s from
    ///     - authorization: The `String` that should written in the `Authorization` header field
    /// - Returns: The created `Element` from the web service or throws an `Error` in the case of an error
    static func postElement<T: Codable>(
        _ element: T,
        authorization: String? = authorization,
        on route: URL
    ) async throws -> T {
        try await execute(urlRequest("POST", url: route, authorization: authorization, body: try? encoder.encode(element)))
    }
    
    /// Updates an `Element`s to a `URL` specified by `route`
    /// - Parameters:
    ///     - element: The `Element` that should be updated
    ///     - route: The route to get the `Element`s from
    ///     - authorization: The `String` that should written in the `Authorization` header field
    /// - Returns: The updated `Element` from the web service or throws an `Error` in the case of an error
    static func putElement<T: Codable>(
        _ element: T,
        authorization: String? = authorization,
        on route: URL
    ) async throws -> T {
        try await execute(urlRequest("PUT", url: route, authorization: authorization, body: try? encoder.encode(element)))
    }
    
    /// Deletes a Resource identifed by an `URL` specified by `route`
    /// - Parameters:
    ///     - route: The route that identifes the resource
    ///     - authorization: The `String` that should written in the `Authorization` header field
    static func delete(
        at route: URL,
        authorization: String? = authorization
    ) async throws {
        let response = try await URLSession.shared.data(for: urlRequest("DELETE", url: route, authorization: authorization)).1
        
        guard let response = response as? HTTPURLResponse, 200..<299 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
}
