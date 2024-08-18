//
//  MovieTableViewControllerTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18/08/2024.
//

import XCTest
@testable import MovieChallange

final class MovieTableViewControllerTests: XCTestCase {
    var window: UIWindow!
    private var viewController: MovieTableViewController!
    
    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()
    
    override func setUp() {
        window = UIWindow(frame: .init(x: 0, y: 0, width: 393, height: 852))
    }
    
    private func createViewController(with viewModel: MovieSearchViewModel) {
        viewController = MovieTableViewController(viewModel: viewModel)
        viewController.view.frame = .init(origin: .zero, size: .init(width: 393, height: 852))
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        viewController.loadViewIfNeeded()
    }

    func testFetching() throws {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedOMDbSearchRepo(bundle: bundle))
        createViewController(with: viewModel)
        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
                
        DispatchQueue.main.async {
            XCTAssert(viewModel.statusSubscriber.value == .loaded)
            XCTAssertEqual(viewModel.movies.count, 2)
            XCTAssertEqual(self.viewController.tableView(self.viewController.tableView, numberOfRowsInSection: 0), 2)
            
            let model = viewModel.movies[0]
            self.testFirstModel(model)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchingWithPagination() throws {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedOMDbSearchRepo(bundle: bundle))
        createViewController(with: viewModel)

        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssert(viewModel.statusSubscriber.value == .completed)
            XCTAssertEqual(viewModel.movies.count, 4)
            XCTAssertEqual(self.viewController.tableView(self.viewController.tableView, numberOfRowsInSection: 0), 4)

            let model = viewModel.movies[2]
            self.testThirdModel(model)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testFetchingFailing() throws {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: MockedFailingOMDbSearchRepo())
        createViewController(with: viewModel)

        let expectation = XCTestExpectation(description: "Fetching search results asynchronously.")
                
        DispatchQueue.main.async {
            if case .failed(_) = viewModel.statusSubscriber.value {
                XCTAssert(viewModel.movies.isEmpty)
                XCTAssertEqual(self.viewController.tableView(self.viewController.tableView, numberOfRowsInSection: 0), 0)
                XCTAssertTrue(self.viewController.presentedViewController?.isKind(of: UIAlertController.self) ?? false)
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
