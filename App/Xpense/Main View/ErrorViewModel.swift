//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: ErrorViewModel
/// The `ErrorViewModel` that is responsible for showing errors originating from the `Model`
protocol ErrorViewModel: ObservableObject {
    /// The human readable error message that should be displayed to the user
    var errorMessage: String? { get }
    /// A `Bool` `Binding` that indicates whether there is a error message that should be displayed
    var presentingErrorMessage: Binding<Bool> { get }
}


// MARK: Model + ErrorViewModel
extension Model: ErrorViewModel {
    var errorMessage: String? {
        self.webServiceError?.localizedDescription
    }
    
    var presentingErrorMessage: Binding<Bool> {
        Binding(get: {
            self.webServiceError != nil
        }, set: { newValue in
            guard !newValue else {
                return
            }
            self.resolveWebServiceError()
        })
    }
}
