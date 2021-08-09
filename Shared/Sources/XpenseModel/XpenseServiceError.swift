//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: XpenseServiceError
/// An `Error` that details possible errors that can occur when interacting with Xpense Web Service
public enum XpenseServiceError: Error {
    /// Use this error in case the decoding of a message from the web service failed
    case loginFailed
    /// Use this error in case the sign up process failed
    case signUpFailed
    /// Use this error if saving a resource on the Xpense Web Service failed
    case loadingFailed(Codable.Type)
    /// Use this error if an unknown and unexpected error occurred
    case saveFailed(Codable.Type)
    /// Use this error if deleting a resource on the Xpense Web Service failed
    case deleteFailed(Codable.Type)
    /// Use this error if the user token seems to have expired and the user needs to login again
    case unknown
    
    
    public var localizedDescription: String {
        switch self {
        case .loginFailed:
            return """
                The login failed.
                Please make sure that you are connected to the internet, signed up, and the credentials are correct.
            """
        case .signUpFailed:
            return """
                Could not sign up.
                Please make sure that you are connected to the internet or choose an other name, the name seems to be taken.
            """
        case let .loadingFailed(type):
            return """
                Could not load the \(type.self)s from the Xpense Web Service.
                Please make sure that you are connected to the internet.
                If this error persists try signing out and logging back in.
            """
        case let .saveFailed(type):
            return """
                Could not save the \(type.self) on the Xpense Web Service.
                Please make sure that you are connected to the internet.
                If this error persists try signing out and logging back in.
            """
        case let .deleteFailed(type):
            return """
                Could not delete the \(type.self) on the Xpense Web Service.
                Please make sure that you are connected to the internet.
                Make sure there is no data associated to the object you want to delete, e.g. Transactions of an Account.
                If this error persists try signing out and logging back in.
            """
        case .unknown:
            return """
                An unknown error occured.
                Please check your internet connection.
                The Xpense developer did a bad job.
            """
        }
    }
}
