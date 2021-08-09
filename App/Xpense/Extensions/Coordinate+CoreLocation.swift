//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import CoreLocation
import XpenseModel


extension Coordinate {
    /// This `Transaction`'s location stored as a 2D Core Location Coordinate
    var clCoordinate: CLLocationCoordinate2D? {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    /// - Parameters:
    ///   - coordinate: The Core Location 2D coordindate that should be used to initialize the `Coordinate`
    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(coordinate.latitude, coordinate.longitude)
    }
}
