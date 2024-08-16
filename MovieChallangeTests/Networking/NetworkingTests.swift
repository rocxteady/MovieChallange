import XCTest
@testable import MovieChallange

final class NetworkingTests: XCTestCase {
    private let configuration = URLSessionConfiguration.default

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        configuration.protocolClasses = [MockedURLService.self]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        configuration.protocolClasses = nil
    }

    func testErrors() {
        let urlMalformed = NetworkError.urlMalformed
        XCTAssertNotNil(urlMalformed.errorDescription, "NetworkError case should not be nil!")
        let statusCode = NetworkError.statusCode(403)
        XCTAssertNotNil(statusCode.errorDescription, "NetworkError case should not be nil!")
        let unknown = NetworkError.unknown
        XCTAssertNotNil(unknown.errorDescription, "NetworkError case should not be nil!")
    }

    func test() {
        MockedURLService.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: "http://www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let exampleString = "{\"title\":\"Title Example\"}"
            let exampleData = exampleString.data(using: .utf8)
            return (response, exampleData)
        }
        let networkClient = NetworkClient(configuration: configuration)

        let expectation = XCTestExpectation(description: "Fetching asynchronously.")
        
        networkClient.fetch(with: "http://www.example.com", returnType: MockedModel.self) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.title, "Title Example", "Response data don't match the example data!")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testWithFailure() {
        MockedURLService.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: "http://www.example.com")!, statusCode: 403, httpVersion: nil, headerFields: nil)
            return (response, nil)
        }
        
        let networkClient = NetworkClient(configuration: configuration)

        let expectation = XCTestExpectation(description: "Fetching asynchronously.")

        networkClient.fetch(with: "http://www.example.com", returnType: MockedModel.self) { result in
            switch result {
            case .success:
                XCTFail("Downloading should have been failed with a status code!!")
            case .failure(let error):
                if let error = error as? NetworkError,
                      case .statusCode(_) = error {
                    print("Succed")
                } else {
                    XCTFail(error.localizedDescription)
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
