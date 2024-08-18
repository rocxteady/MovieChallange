//
//  OMDbSearchParamsTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 19/08/2024.
//

import XCTest
@testable import MovieChallange

final class OMDbSearchParamsTests: XCTestCase {

    func test() {
        var params = OMDbSearchParams(term: "term")
        params.page = 2
        let dictionary = params.toDictionary
        XCTAssertEqual(dictionary["s"] as? String, "term")
        XCTAssertEqual(dictionary["page"] as? Int, 2)
    }

}
