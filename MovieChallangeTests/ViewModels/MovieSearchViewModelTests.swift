//
//  MovieSearchViewModelTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import XCTest
@testable import MovieChallange

final class MovieSearchViewModelTests: XCTestCase {
    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()

    func testFetching() throws {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedOMDbSearchRepo(bundle: bundle))
        
        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
        
        viewModel.setSearchTerm("Star Wars")
        
        DispatchQueue.main.async {
            XCTAssert(viewModel.statusSubscriber.value == .loaded)
            XCTAssertEqual(viewModel.movies.count, 2)
            
            let model = viewModel.movies[0]
            self.testFirstModel(model)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchingWithPagination() throws {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedOMDbSearchRepo(bundle: bundle))
        
        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
        
        viewModel.fetch()
        
        DispatchQueue.main.async {
            viewModel.fetchIfLast(at: 1)
            DispatchQueue.main.async {
                XCTAssert(viewModel.statusSubscriber.value == .completed)
                XCTAssertEqual(viewModel.movies.count, 4)
                
                let model = viewModel.movies[2]
                self.testThirdModel(model)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchingFailing() throws {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedFailingOMDbSearchRepo())
        
        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
        
        viewModel.fetch()
        
        DispatchQueue.main.async {
            if case .failed(_) = viewModel.statusSubscriber.value {
                XCTAssert(viewModel.movies.isEmpty)
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
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedAPIFailingOMDbSearchRepo(bundle: bundle))
        
        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
        
        viewModel.fetch()
        
        DispatchQueue.main.async {
            if case .failed(let error) = viewModel.statusSubscriber.value {
                guard let error = error as? OMDbAPIError,
                   case .apiError = error else {
                    XCTFail(error.localizedDescription)
                    return
                }
                XCTAssert(viewModel.movies.isEmpty)
                viewModel.resetError()
                XCTAssertEqual(viewModel.statusSubscriber.value, .idle)
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    private func testFirstModel(_ model: OMDbMovie) {
        XCTAssertEqual(model.title, "Star Wars: Episode IV - A New Hope")
        XCTAssertEqual(model.year, "1977")
        XCTAssertEqual(model.imdbID, "tt0076759")
        XCTAssertEqual(model.type, .movie)
        XCTAssertEqual(model.poster, "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg")
    }

    private func testThirdModel(_ model: OMDbMovie) {
        XCTAssertEqual(model.title, "Star Wars: Episode IX - The Rise of Skywalker")
        XCTAssertEqual(model.year, "2019")
        XCTAssertEqual(model.imdbID, "tt2527338")
        XCTAssertEqual(model.type, .movie)
        XCTAssertEqual(model.poster, "https://m.media-amazon.com/images/M/MV5BMDljNTQ5ODItZmQwMy00M2ExLTljOTQtZTVjNGE2NTg0NGIxXkEyXkFqcGdeQXVyODkzNTgxMDg@._V1_SX300.jpg")
    }
}
