//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import MapKit


/// Used to have identifiable annotation items for a SwiftUI Map View
struct IdentifiableCoordinate2DWrapper: Identifiable {
    /// Uniquly identifies a `IdentifiableCoordinate2DWrapper`
    var id = UUID()
    /// The coordinate that should be displayed on the map
    var coordinate: CLLocationCoordinate2D
}
