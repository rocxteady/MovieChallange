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
    
    func testUnsubscribe() throws {
        XCTAssertEqual(valueSubsriber.value, "Test")
        valueSubsriber.setValue("Value")
        
        var isSubscribed: Bool = true
        
        subsriptionIndex = valueSubsriber.subscribe { value in
            if isSubscribed {
                XCTAssertEqual(value, "Value")
            } else {
                XCTAssertNotEqual(value, "Value2")
            }
        }
        if let subsriptionIndex {
            valueSubsriber.unsubscribe(index: subsriptionIndex)
            isSubscribed = false
            valueSubsriber.setValue("Value2")
        } else {
            XCTFail()
        }
    }

    deinit {
        guard let subsriptionIndex else { return }
        valueSubsriber.unsubscribe(index: subsriptionIndex)
    }
}
