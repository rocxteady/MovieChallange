//
//  MockError.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import Foundation

enum MockError: LocalizedError {
    case fileNotFound(String)

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let string):
            return "File \(string) could not be found."
        }
    }
}
