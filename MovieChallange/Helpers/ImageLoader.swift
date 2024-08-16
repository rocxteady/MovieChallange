//
//  ImageLoader.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import Foundation
import UIKit.UIImage

final class ImageLoader {
    private var task: URLSessionDataTask?

    private static let urlCache: URLCache = {
        let memoryCapacity = 20 * 1024 * 1024 // 20 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ImageCache")
        return cache
    }()

    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        config.urlCache = urlCache
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if let cachedResponse = Self.urlCache.cachedResponse(for: URLRequest(url: url)) {
            completion(.success(UIImage(data: cachedResponse.data)))
        }
        
        task = Self.session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            guard let data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            Self.urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
            completion(.success(UIImage(data: cachedResponse.data)))
        }
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
}
