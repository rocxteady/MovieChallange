//
//  OMDbParamsCreatorTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 19/08/2024.
//

import XCTest
@testable import MovieChallange

final class OMDbParamsCreatorTests: XCTestCase {
    
    func testDefaults() throws {
        let params = OMDbParamsCreator.createWith(params: nil)
        XCTAssertNotNil(params["apikey"])
    }
    
    func test() throws {
        let params = OMDbParamsCreator.createWith(params: ["key": "value"])
        XCTAssertNotNil(params["apikey"])
        XCTAssertEqual(params["key"] as? String, "value")
    }

    func testOverwriting() throws {
        let randomString = UUID().uuidString
        let params = OMDbParamsCreator.createWith(params: ["apikey": randomString])
        XCTAssertEqual(params["apikey"] as? String, randomString)
    }
    
}
