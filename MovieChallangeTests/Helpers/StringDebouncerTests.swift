//
//  StringDebouncerTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import XCTest
@testable import MovieChallange

final class StringDebouncerTests: XCTestCase {

    func test() throws {
        let debouncer = StringDebouncer()
        
        let expectation = XCTestExpectation(description: "Debouncing text.")

        debouncer.debounce(text: "a", debounceInterval: 0.1) { text in
            XCTFail()
        }
        debouncer.debounce(text: "b", debounceInterval: 0.1) { text in
            XCTFail()
        }
        debouncer.debounce(text: "c", debounceInterval: 0.1) { text in
            XCTAssertEqual(text, "c")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }

}
