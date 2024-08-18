//
//  OMDbSearchResponse+Preview.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//
#if DEBUG
import Foundation

extension OMDbSearchResponse {
    static var preview: OMDbSearchResponse {
        .init(result: .preview, error: nil, totalResults: 20)
    }
    
    static var preview2: OMDbSearchResponse {
        .init(result: .preview2, error: nil, totalResults: 20)
    }
}
#endif
