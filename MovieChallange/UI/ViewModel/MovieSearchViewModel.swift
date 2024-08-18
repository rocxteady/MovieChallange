//
//  MovieSearchViewModel.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

enum SearchStatus {
    case idle
    case loading
    case loaded
    case completed
    case failed(Error)
    
    var canLoad: Bool {
        if case .completed = self {
            return false
        } else if case .loading = self {
            return false
        }
        return true
    }
}

extension SearchStatus: Equatable {
    static func == (lhs: SearchStatus, rhs: SearchStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded, .loaded): return true
        case (.completed, .completed): return true
        default:
            return false
        }
    }
}

class MovieSearchViewModel {
    private let defaultSearchTerm: String
    private let repo: OMDbSearchRepo
    private var params: OMDbSearchParams = .init()
    private var totalCount: Int = 0

    private(set) var movies: [OMDbMovie] = []
    var statusSubscriber: ValueSubscriber<SearchStatus> = .init(value: .idle)
    
    init(defaultSearchTerm: String, repo: OMDbSearchRepo) {
        self.defaultSearchTerm = defaultSearchTerm
        self.repo = repo
        self.params.term = defaultSearchTerm
    }
    
    func resetError() {
        statusSubscriber.setValue(totalCount > 0 ? .loaded : .idle)
    }
    
    func getMovie(at index: Int) -> OMDbMovie {
        movies[index]
    }
}

//MARK: Search
extension MovieSearchViewModel {
    func setSearchTerm(_ term: String) {
        params.term = term
        fetch(shouldReset: true)
    }
}

//MARK: API
extension MovieSearchViewModel {
    func fetch(shouldReset: Bool = true) {
        if shouldReset || params.term.isEmpty {
            reset()
        }
        
        guard statusSubscriber.value.canLoad else { return }
        
        statusSubscriber.setValue(.loading)
        
        repo.fetch(params: params) { [weak self] result in
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
    
    func fetchIfLast(at index: Int) {
        let movie = movies[index]
        if movie == movies.last {
            fetch(shouldReset: false)
        }
    }
    
    private func handleResponse(_ response: OMDbSearchResponse) {
        totalCount += response.result.count
        movies.append(contentsOf: response.result)
        params.page += 1
        if totalCount >= response.totalResults {
            statusSubscriber.setValue(.completed)
        } else {
            statusSubscriber.setValue(.loaded)
        }
    }
    
    private func reset() {
        repo.cancel()
        movies = []
        params.term = defaultSearchTerm
        params.page = 1
        totalCount = 0
        statusSubscriber.setValue(.idle)
    }
}
