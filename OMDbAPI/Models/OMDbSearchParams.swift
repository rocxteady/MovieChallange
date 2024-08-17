//
//  OMDbSearchParams.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbSearchParams {
    var term: String
    var page: Int = 1
    
    init(term: String = "") {
        self.term = term
    }
}

extension OMDbSearchParams: ConvertableToDictionary {
    var toDictionary: [String : Any] {
        [
            "s": term,
            "page": page,
        ]
    }
}
