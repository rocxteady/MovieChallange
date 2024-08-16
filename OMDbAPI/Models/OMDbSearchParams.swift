//
//  OMDbSearchParams.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbSearchParams {
    let term: String
    let page: Int = 1
}

extension OMDbSearchParams: ConvertableToDictionary {
    var toDictionary: [String : Any] {
        [
            "s": term,
            "page": page,
        ]
    }
}
