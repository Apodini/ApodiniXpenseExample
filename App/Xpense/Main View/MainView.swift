//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - MainView
/// The entry-point of the app.
struct MainView: View {
    // The `Model` the   `User` shall be read from
    @EnvironmentObject private var model: Model
    
    
    var body: some View {
        if model.user == nil {
            LoginView(model)
        } else {
            TabView {
                AccountsOverview()
                    .tabItem {
                        Image(systemName: "rectangle.stack")
                        Text("Accounts")
                    }
                TransactionsOverview()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Transactions")
                    }
            }
        }
    }
}


// MARK: - MainView Previews
struct MainView_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    
    static var previews: some View {
        MainView()
            .environmentObject(model)
    }
}
