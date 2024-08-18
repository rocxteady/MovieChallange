//
//  OMDbDetailRepo+Preview.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//
#if DEBUG
import Foundation

struct PreviewOMDbDetailRepo: OMDbDetailRepo {
    func fetch(movieId: String, completion: @escaping (Result<OMDbMovieDetail, any Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(.success(.preview))
        }
    }
    
    func cancel() {}
}
#endif
