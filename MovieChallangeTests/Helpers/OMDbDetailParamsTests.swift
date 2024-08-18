//
//  OMDbDetailParamsTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 19/08/2024.
//

import XCTest
@testable import MovieChallange

final class OMDbDetailParamsTests: XCTestCase {

    func test() {
        let params = OMDbDetailParams(id: "0", plot: .full)
        let dictionary = params.toDictionary
        XCTAssertEqual(dictionary["i"] as? String, "0")
        XCTAssertEqual(dictionary["plot"] as? String, "full")
    }

}
