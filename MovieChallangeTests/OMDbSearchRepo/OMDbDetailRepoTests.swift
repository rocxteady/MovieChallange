//
//  OMDbDetailRepoTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18.08.2024.
//

import XCTest
@testable import MovieChallange

final class OMDbDetailRepoTests: XCTestCase {
    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()

    func testSuccess()  {
        let repo = MockedOMDbDetailRepo(bundle: bundle)
        
        let expectation = XCTestExpectation(description: "Fetching movie detail asynchronously.")
        
        repo.fetch(params: .init(id: "0", plot: .full)) { [weak self] result in
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

    private func testModel(_ model: OMDbMovieDetail) {
        XCTAssertEqual(model.title, "Star Wars: Episode IV - A New Hope")
        XCTAssertEqual(model.year, "1977")
        XCTAssertEqual(model.imdbID, "tt0076759")
        XCTAssertEqual(model.type, .movie)
        XCTAssertEqual(model.poster, "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg")
        XCTAssertEqual(model.director, "George Lucas")
        XCTAssertEqual(model.plot, "The Imperial Forces, under orders from cruel Darth Vader, hold Princess Leia hostage in their efforts to quell the rebellion against the Galactic Empire. Luke Skywalker and Han Solo, captain of the Millennium Falcon, work together with the companionable droid duo R2-D2 and C-3PO to rescue the beautiful princess, help the Rebel Alliance and restore freedom and justice to the Galaxy.")
    }
}
