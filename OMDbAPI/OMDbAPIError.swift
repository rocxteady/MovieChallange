//
//  OMDbAPIError.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18.08.2024.
//

import Foundation

enum OMDbAPIError: LocalizedError {
    case apiError(String)
    
    var errorDescription: String? {
        switch self {
        case .apiError(let description):
            description
        }
    }
}
