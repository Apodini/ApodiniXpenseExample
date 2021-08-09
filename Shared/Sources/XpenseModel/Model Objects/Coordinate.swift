//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: Coordinate
/// Represents a single point on earth, specified by latitude and longitude.
public struct Coordinate {
    /// The latitude of the Coordinate
    public var latitude: Double
    /// The longitude of the Coordinate
    public var longitude: Double
    
    
    /// - Parameters:
    ///   - latitude: The latitude of the Coordinate
    ///   - longitude: The longitude of the Coordinate
    public init(_ latitude: Double, _ longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}


// MARK: Coordinate: Codable
extension Coordinate: Codable {}


// MARK: Coordinate: Hashable
extension Coordinate: Hashable {}
