//
//  ValueSubscriberTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import XCTest
@testable import MovieChallange

final class ValueSubscriberTests: XCTestCase {
    private var subsriptionIndex: Int?
    let valueSubsriber: ValueSubscriber<String> = .init(value: "Test")

    func test() throws {
        XCTAssertEqual(valueSubsriber.value, "Test")
        valueSubsriber.setValue("Value")
        
        subsriptionIndex = valueSubsriber.subscribe { value in
            XCTAssertEqual(value, "Value")
        }
    }

    deinit {
        guard let subsriptionIndex else { return }
        valueSubsriber.unsubscribe(index: subsriptionIndex)
    }
}
