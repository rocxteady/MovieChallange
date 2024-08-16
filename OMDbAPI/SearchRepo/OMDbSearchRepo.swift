//
//  OMDbSearchRepo.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

protocol OMDbSearchRepo {
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, Error>) -> Void)
}

struct RemoteOMDBSearchRepo: OMDbSearchRepo {
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, any Error>) -> Void) {
        let networkClient = NetworkClient(configuration: .default)
        networkClient.fetch(with: OMDbAPIConstants.baseURLString, returnType: OMDbSearchResponse.self, params: params.toDictionary, completion: completion)
    }
}
