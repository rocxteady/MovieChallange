//
//  OMDbResponse.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbSearchResponse: Decodable, StatusResponse, TotalResultsResponse {
    var result: [OMDbMovie]
    var error: String?
    var response: String
    var totalResults: Int
    
    private var totalResultsString: String
    
    private enum CodingKeys: String, CodingKey {
        case result = "Search"
        case response = "Response"
        case error = "Error"
        case totalResultsString = "totalResults"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decodeIfPresent([OMDbMovie].self, forKey: .result) ?? []
        self.response = try container.decode(String.self, forKey: .response)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.totalResultsString = try container.decodeIfPresent(String.self, forKey: .totalResultsString) ?? "0"
        self.totalResults = Int(self.totalResultsString) ?? 0
    }
}
