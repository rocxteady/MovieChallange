//
//  OMDbAPI.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

struct OMDbAPI {
    static var apiKey: String {
        guard let _apiKey else {
            fatalError("You have not configure OMDbAPI with an API Key")
        }
        return _apiKey
    }
    
    private static var _apiKey: String?
    
    static func configureWith(apiKey: String) {
        _apiKey = apiKey
    }
}

extension OMDbAPI {
    static var defaultParams: [String: Any] {
        ["apikey": apiKey]
    }
}
