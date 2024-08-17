//
//  OMDbSearchRepo+Preview.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//
#if DEBUG
import Foundation

struct PreviewOMDbSearchRepo: OMDbSearchRepo {
    func fetch(params: OMDbSearchParams, completion: @escaping (Result<OMDbSearchResponse, any Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if params.page % 2 == 0 {
                completion(.success(.preview2))
                return
            }
            completion(.success(.preview))
        }
    }
    
    func cancel() {}
}
#endif
