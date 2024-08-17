//
//  OMDbParamsCreator.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

struct OMDbParamsCreator {
    static func createWith(params: [String: Any]?) -> [String: Any] {
        let defaultParams = OMDbAPI.defaultParams
        guard let params else {
            return defaultParams
        }
        return defaultParams.merging(params) { (_, new) in new }
    }
}
