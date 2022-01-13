//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import RESTfulXpenseModel
import SwiftUI


@main
struct XpenseApp: App {
    @StateObject var model: Model = {
        #if RELEASE
            return RestfulModel()
        #else
            return LocalStorageModel()
        #endif
    }()
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .alert(isPresented: model.presentingErrorMessage) {
                    Alert(title: Text("Error"),
                          message: Text(model.errorMessage ?? ""))
                }
                .environmentObject(model)
        }
    }
}
