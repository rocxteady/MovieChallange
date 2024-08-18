//
//  MovieDetailViewModelTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18.08.2024.
//

import XCTest
@testable import MovieChallange

final class MovieDetailViewModelTests: XCTestCase {
    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()

    func testFetching() throws {
        let viewModel = MovieDetailViewModel(movieId: "0", repo: MockedOMDbDetailRepo(bundle: bundle))
        
        let expectation = XCTestExpectation(description: "Fetching movie detail asynchronously.")
        
        viewModel.fetch()
        
        DispatchQueue.main.async {
            XCTAssert(viewModel.statusSubscriber.value == .loaded)
            if let movieDetail = viewModel.movieDetail {
                self.testModel(movieDetail)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchingWhileLoading() throws {
        let viewModel = MovieDetailViewModel(movieId: "0", repo: MockedOMDbDetailRepo(bundle: bundle))

        viewModel.fetch()
        XCTAssertFalse(viewModel.statusSubscriber.value.canLoad)
    }
    
    func testFetchingFailing() throws {
        let viewModel = MovieDetailViewModel(movieId: "0", repo: MockedFailingOMDbDetailRepo())

        let expectation = XCTestExpectation(description: "Fetching movie detail asynchronously.")
        
        viewModel.fetch()
        
        DispatchQueue.main.async {
            if case .failed(_) = viewModel.statusSubscriber.value {
                XCTAssertNil(viewModel.movieDetail)
                viewModel.resetError()
                XCTAssertEqual(viewModel.statusSubscriber.value, .idle)
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchingWithAPIFailing() throws {
        let viewModel = MovieDetailViewModel(movieId: "0", repo: MockedAPIFailingOMDbDetailRepo(bundle: bundle))

        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
        
        viewModel.fetch()
        
        DispatchQueue.main.async {
            if case .failed(let error) = viewModel.statusSubscriber.value {
                guard let error = error as? OMDbAPIError,
                   case .apiError = error else {
                    XCTFail(error.localizedDescription)
                    return
                }
                XCTAssertNil(viewModel.movieDetail)
                viewModel.resetError()
                XCTAssertEqual(viewModel.statusSubscriber.value, .idle)
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
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
