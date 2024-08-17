//
//  OMDbSearchRepo+Mock.swift
//  MovieChallangeTests
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import Foundation
@testable import MovieChallange

struct MockedOMDbSearchRepo: OMDbSearchRepo {
    let bundle: Bundle
    
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, any Error>) -> Void) {
        do {
            let response = try OMDbSearchResponse.testData(for: bundle, for: params.page)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
    
    func cancel() {}
}

struct MockedFailingOMDbSearchRepo: OMDbSearchRepo {
    let bundle: Bundle
    
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, any Error>) -> Void) {
        completion(.failure(MockError.fileNotFound("")))
    }
    
    func cancel() {}
}
