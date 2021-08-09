//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import XpenseModel


// MARK: - AccountDetailLink
/// A label with a card background showing the name of an `Account` and the option to navigate to that `Account`
struct AccountDetailLink: View {
    /// The `Model` the   `Account` shall be read from
    @EnvironmentObject private var model: Model
    /// Indicate whether to disable the navigation link
    var disableLink: Bool
    
    /// The `Account`'s identifier that should be used to display the corresponding `Account`
    ///
    /// We do explicitly **not** wrap this property with an `@State` property wrapper as this would not update the `AccountDetailLink` if the
    /// parent view's properties marked with `@State` are changed, and the view should be redrawn.
    ///
    /// Wrapping the property with `@State` would move the storage of the property out if the `AccountDetailLink` struct. This would result in
    /// SwiftUI injecting the value every time the view is evaluated, resulting in an outdated view representation.
    var id: Account.ID
    
    
    var body: some View {
        model.account(id).map { account in
            NavigationLink(destination: AccountView(id: id)) {
                HStack {
                    Text(account.name)
                    Spacer()
                    if disableLink {
                        Image(systemName: "chevron.right")
                    }
                }.padding(16)
                    .cardViewModifier()
                    .foregroundColor(.primary)
            }.padding(16)
                .disabled(disableLink)
        }
    }
}


// MARK: - AccountDetailLink Previews
struct AccountDetailLink_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    private static var accountId = model.accounts.first!.id // swiftlint:disable:this force_unwrapping
    
    
    static var previews: some View {
        ForEach(ContentSizeCategory.allCases, id: \.hashValue) { contentSizeCategory in
            AccountDetailLink(disableLink: false, id: accountId)
                .environment(\.sizeCategory, contentSizeCategory)
        }.environmentObject(model)
            .background(Color("BackgroundColor"))
            .previewLayout(.sizeThatFits)
    }
}
