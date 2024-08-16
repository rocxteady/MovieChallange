//
//  OMDbSearchResponse+Mock.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import Foundation
@testable import MovieChallange

extension OMDbSearchResponse {
    static func testData(for bundle: Bundle, for page: Int) throws -> OMDbSearchResponse {
        let fileName = page == 2 ? "star_search_result_second": "star_search_result_first"
        guard let pathURL = bundle.url(forResource: fileName, withExtension: "json") else {
            throw MockError.fileNotFound("\(fileName).json")
        }
        let data = try Data(contentsOf: pathURL)
        let response = try JSONDecoder().decode(OMDbSearchResponse.self, from: data)
        return response
    }
}

