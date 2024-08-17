//
//  OMDbAPITests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import XCTest
@testable import MovieChallange

// This testing fatal error stuff built with the help of ChatGPT
 
// Global unreachable function
fileprivate func unreachable() -> Never {
    repeat {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    } while (true)
}

// Custom fatalError implementation for testing
fileprivate func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

enum FatalErrorUtil {
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}

class OMDbAPIFailingTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        FatalErrorUtil.restoreFatalError()
    }

    func testFatalError() {
        let expectation = self.expectation(description: "Expecting fatal error")

        // Override the fatalError function
        FatalErrorUtil.replaceFatalError { message, file, line in
            expectation.fulfill()
            unreachable()
        }

        // This should trigger fatalError
        DispatchQueue.global(qos: .userInitiated).async {
            // Your code that triggers fatalError
            _ = OMDbAPI.apiKey
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
}
