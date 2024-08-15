//
//  NetworkError.swift
//
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

/// Represents errors related to the `NetworkClient` operations.
enum NetworkError: LocalizedError {
    /// Represents a malformed URL error.
    case urlMalformed

    /// Represents an unexpected HTTP status code error.
    /// Contains the status code and, optionally, the returned data.
    case statusCode(Int)

    /// Provides a human-readable description for the error.
    ///
    /// This can be useful for displaying the error message to the user.
    case unknown

    var errorDescription: String? {
        switch self {
        case .urlMalformed:
            return "URL malformed."
        case .statusCode(let code):
            return "HTTP returned unxpected \(code) code."
        case .unknown:
            return "Unknown error."
        }
    }
}
