//
//  OMDbAPITests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import XCTest
@testable import MovieChallange

final class OMDbAPITests: XCTestCase {

    func test() {
        OMDbAPI.configureWith(apiKey: "api_key")
        XCTAssertEqual(OMDbAPI.apiKey, "api_key")
    }

}
