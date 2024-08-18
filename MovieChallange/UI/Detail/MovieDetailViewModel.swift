//
//  MovieDetailViewModel.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

enum MovieDetailStatus {
    case idle
    case loading
    case loaded
    case failed(Error)
    
    var canLoad: Bool {
        if case .loading = self {
            return false
        }
        return true
    }
}

extension MovieDetailStatus: Equatable {
    static func == (lhs: MovieDetailStatus, rhs: MovieDetailStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded, .loaded): return true
        default:
            return false
        }
    }
}

class MovieDetailViewModel {
    private let movieId: String
    private let repo: OMDbDetailRepo

    private(set) var movieDetail: OMDbMovieDetail?
    var statusSubscriber: ValueSubscriber<MovieDetailStatus> = .init(value: .idle)
    
    init(movieId: String, repo: OMDbDetailRepo) {
        self.movieId = movieId
        self.repo = repo
    }
}

//MARK: API
extension MovieDetailViewModel {
    func fetch(shouldReset: Bool = true) {
        guard statusSubscriber.value.canLoad else { return }
        
        statusSubscriber.setValue(.loading)
        
        repo.fetch(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleResponse(response)
                case .failure(let error):
                    self?.statusSubscriber.setValue(.failed(error))
                }
            }
        }
    }

    func resetError() {
        statusSubscriber.setValue(movieDetail == nil ? .idle : .loaded)
    }
    
    private func handleResponse(_ response: OMDbMovieDetail) {
        movieDetail = response
        statusSubscriber.setValue(.loaded)
    }
}
