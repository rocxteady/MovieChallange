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
        .init(result: .preview, response: "True", totalResultsString: "6")
    }
}
#endif
