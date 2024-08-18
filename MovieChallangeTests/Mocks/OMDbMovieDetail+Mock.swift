//
//  OMDbMovieDetail+Mock.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18.08.2024.
//

import Foundation
@testable import MovieChallange

extension OMDbMovieDetail {
    static func testData(for bundle: Bundle) throws -> OMDbMovieDetail {
        guard let pathURL = bundle.url(forResource: "detail", withExtension: "json") else {
            throw MockError.fileNotFound("detail.json")
        }
        let data = try Data(contentsOf: pathURL)
        let response = try JSONDecoder().decode(OMDbMovieDetail.self, from: data)
        return response
    }
    
    static func errorData(for bundle: Bundle) throws -> OMDbMovieDetail {
        guard let pathURL = bundle.url(forResource: "error", withExtension: "json") else {
            throw MockError.fileNotFound("error.json")
        }
        let data = try Data(contentsOf: pathURL)
        let response = try JSONDecoder().decode(OMDbMovieDetail.self, from: data)
        return response
    }
}

