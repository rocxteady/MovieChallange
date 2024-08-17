//
//  OMDbSearchRepo.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

protocol OMDbSearchRepo {
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, Error>) -> Void)
    func cancel()
}

struct RemoteOMDBSearchRepo: OMDbSearchRepo {
    let networkClient = NetworkClient(configuration: .default)
    
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, any Error>) -> Void) {
        networkClient.fetch(with: OMDbAPIConstants.baseURLString, returnType: OMDbSearchResponse.self, params: OMDbParamsCreator.createWith(params: params.toDictionary), completion: completion)
    }
    
    func cancel() {
        networkClient.cancel()
    }
}
