//
//  OMDbSearchRepoTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import XCTest
@testable import MovieChallange

final class OMDbSearchRepoTests: XCTestCase {
    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()

    func testSuccess()  {
        let repo = MockedOMDbSearchRepo(bundle: bundle)
        
        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
        
        repo.fetch(params: .init(term: "Start")) { [weak self] result in
            switch result {
            case .success(let response):
                self?.testModel(response)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    private func testModel(_ model: OMDbSearchResponse) {
        XCTAssertTrue(model.isSuccess)
        XCTAssertEqual(model.totalResults, 4)
        XCTAssertEqual(model.result.count, 2)
        
        let first = model.result[0]
        
        XCTAssertEqual(first.title, "Star Wars: Episode IV - A New Hope")
        XCTAssertEqual(first.year, "1977")
        XCTAssertEqual(first.imdbID, "tt0076759")
        XCTAssertEqual(first.type, .movie)
        XCTAssertEqual(first.poster, "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg")
    }
}
