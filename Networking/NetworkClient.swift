//
//  NetworkClient.swift
//
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

/// A network client for making asynchronous HTTP requests.
class NetworkClient {
    private lazy var session: URLSession = URLSession(configuration: configuration)
    private let configuration: URLSessionConfiguration
    private let dataDecoder: DataDecoder
    
    /// Initializes a new NetworkClient with the given configuration.
    ///
    /// - Parameters:
    ///  - configuration: The URLSessionConfiguration to use for the session.
    ///  - dataDecoder: The DataDecoder to use for decoding responses.
    init(configuration: URLSessionConfiguration, dataDecoder: DataDecoder = JSONDataDecoder()) {
        self.configuration = configuration
        self.dataDecoder = dataDecoder
    }
}

extension NetworkClient {
    /// Fetches data from the specified URL string and decodes it into the specified type.
    ///
    /// - Parameters:
    ///  - urlString: The URL string of the resource to fetch.
    ///  - returnType: The type to decode the data to.
    ///  - completion: The completion handler to call when the request is complete.
    func fetch<T: Decodable>(with urlString: String, returnType: T.Type, params: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void){
        guard var url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlMalformed))
            return
        }
        if let params {
            url = url.withQueryParameters(params) ?? url
        }
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.urlMalformed))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
                return
            }
            guard let data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            do {
                let result = try JSONDecoder().decode(returnType, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


