//
//  MovieDetailViewControllerTests.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18.08.2024.
//

import XCTest
@testable import MovieChallange

final class MovieDetailViewControllerTests: XCTestCase {
    var window: UIWindow!
    private var viewController: MovieDetailViewController!

    private lazy var bundle: Bundle = {
        return Bundle(for: type(of: self))
    }()

    override func setUp() {
        window = UIWindow(frame: .init(x: 0, y: 0, width: 393, height: 852))
    }

    private func createViewController(with viewModel: MovieDetailViewModel) {
        viewController = MovieDetailViewController(viewModel: viewModel)
        viewController.view.frame = .init(origin: .zero, size: .init(width: 393, height: 852))
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        viewController.loadViewIfNeeded()
    }

    func testFetching() throws {
        let viewModel = MovieDetailViewModel(movieId: "0", repo: MockedOMDbDetailRepo(bundle: bundle))
        createViewController(with: viewModel)
        
        let expectation = XCTestExpectation(description: "Fetching movie detail asynchronously.")
                
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

    func testFetchingFailing() throws {
        let viewModel = MovieDetailViewModel(movieId: "0", repo: MockedFailingOMDbDetailRepo())
        createViewController(with: viewModel)

        let expectation = XCTestExpectation(description: "Fetching movie detail asynchronously.")
                
        DispatchQueue.main.async {
            if case .failed(_) = viewModel.statusSubscriber.value {
                XCTAssertNil(viewModel.movieDetail)
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
