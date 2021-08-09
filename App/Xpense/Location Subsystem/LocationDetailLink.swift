//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import CoreLocation
import MapKit
import XpenseModel


// MARK: - LocationDetailLink
/// A view to showcase a location on a map with the option to click on the map to interact with using a `NavigationLink`
struct LocationDetailLink: View {
    /// The coordinate that should be displayed
    var coordinate: CLLocationCoordinate2D
    /// The navigationbar title that should be displayed in the detail view
    var navigationTitle: String
    
    
    var body: some View {
        NavigationLink(destination: locationView) {
            LocationView(coordinate: coordinate)
                .disabled(true)
                .aspectRatio(1.0, contentMode: .fit)
                .cardViewModifier()
                .padding(16)
        }
    }
    
    /// The `LocationView` that should be displayed in the detail view
    private var locationView: some View {
        LocationView(coordinate: coordinate)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(navigationTitle)
    }
}


// MARK: - LocationDetailLink Previews
struct LocationDetailLink_Previews: PreviewProvider {
    private static var transaction = MockModel().transactions.first! // swiftlint:disable:this force_unwrapping
    
    
    static var previews: some View {
        NavigationView {
            LocationDetailLink(coordinate: transaction.location?.clCoordinate ?? CLLocationCoordinate2D(),
                               navigationTitle: transaction.description)
        }
    }
}
