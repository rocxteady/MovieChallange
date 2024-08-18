//
//  OMDbResponse.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbSearchResponse: Decodable, TotalResultsResponse {
    var result: [OMDbMovie]
    var totalResults: Int
    var error: Error?
    
    private var errorString: String?
    private var totalResultsString: String
    
    private enum CodingKeys: String, CodingKey {
        case result = "Search"
        case errorString = "Error"
        case totalResultsString = "totalResults"
    }
    
    init(result: [OMDbMovie], error: Error? = nil, totalResults: Int) {
        self.result = result
        self.error = error
        self.totalResults = totalResults
        self.totalResultsString = "\(totalResults)"
        self.errorString = error?.localizedDescription
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decodeIfPresent([OMDbMovie].self, forKey: .result) ?? []
        self.errorString = try container.decodeIfPresent(String.self, forKey: .errorString)
        self.totalResultsString = try container.decodeIfPresent(String.self, forKey: .totalResultsString) ?? "0"
        self.totalResults = Int(self.totalResultsString) ?? 0
        if let errorString {
            error = OMDbAPIError.apiError(errorString)
        }
    }
}
