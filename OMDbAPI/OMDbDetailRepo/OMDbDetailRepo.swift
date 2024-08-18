//
//  OMDbDetailRepo.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

protocol OMDbDetailRepo {
    func fetch(params: OMDbDetailParams, completion: @escaping (Result<OMDbMovieDetail, Error>) -> Void)
    func cancel()
}

struct RemoteOMDbDetailRepo: OMDbDetailRepo {
    let networkClient = NetworkClient(configuration: .default)
    
    func fetch(params: OMDbDetailParams, completion: @escaping (Result<OMDbMovieDetail, any Error>) -> Void) {
        networkClient.fetch(with: OMDbAPIConstants.baseURLString, returnType: OMDbMovieDetail.self, params: OMDbParamsCreator.createWith(params: params.toDictionary), completion: completion)
    }
    
    func cancel() {
        networkClient.cancel()
    }
}
