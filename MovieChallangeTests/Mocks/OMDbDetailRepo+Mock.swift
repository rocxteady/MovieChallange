//
//  OMDbDetailRepo+Mock.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 18.08.2024.
//

import Foundation
@testable import MovieChallange

struct MockedOMDbDetailRepo: OMDbDetailRepo {
    let bundle: Bundle
    
    func fetch(params: OMDbDetailParams, completion: @escaping (Result<OMDbMovieDetail, any Error>) -> Void) {
        do {
            let response = try OMDbMovieDetail.testData(for: bundle)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
    
    func cancel() {}
}

struct MockedFailingOMDbDetailRepo: OMDbDetailRepo {
    func fetch(params: OMDbDetailParams, completion: @escaping (Result<OMDbMovieDetail, any Error>) -> Void) {
        completion(.failure(MockError.fileNotFound("")))
    }
    
    func cancel() {}
}

struct MockedAPIFailingOMDbDetailRepo: OMDbDetailRepo {
    let bundle: Bundle
    
    func fetch(params: OMDbDetailParams, completion: @escaping (Result<OMDbMovieDetail, any Error>) -> Void) {
        do {
            let response = try OMDbMovieDetail.errorData(for: bundle)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
    
    func cancel() {}
}
