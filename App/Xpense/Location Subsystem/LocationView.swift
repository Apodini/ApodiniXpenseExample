//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import MapKit
import SwiftUI
import XpenseModel


// MARK: - LocationView
/// A view to showcase a location on a map
struct LocationView: View {
    /// The default values for the `LocationView` shared across the Xpense Application
    enum Defaults {
        /// The default span for the `LocationView`
        static let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
    
    
    /// The coordinate of the pin on the map
    var coordinate: CLLocationCoordinate2D
    /// The current coordinate region displayed by the map
    @State var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(),
                                                     span: Defaults.span)
    
    var body: some View {
        Map(coordinateRegion: $coordinateRegion,
            annotationItems: [IdentifiableCoordinate2DWrapper(coordinate: coordinate)]) { coordinateWrapper in
            MapMarker(coordinate: coordinateWrapper.coordinate)
        }.onAppear {
            coordinateRegion.center = coordinate
        }
    }
}


// MARK: - LocationView Previews
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(coordinate: MockModel().transactions.sorted()[0].location?.clCoordinate ?? CLLocationCoordinate2D())
    }
}
