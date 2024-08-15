//
//  MockedURLService.swift
//  
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

class MockedURLService: URLProtocol {
    static var observer: ((URLRequest) throws -> (URLResponse?, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        do {
            guard let (response, data) = try Self.observer?(request) else {
                return
            }
            if let response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}
