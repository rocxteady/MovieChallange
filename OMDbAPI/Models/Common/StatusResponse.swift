//
//  StatusResponse.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

protocol StatusResponse {
    var response: String { get }
    var error: String? { get }
}

extension StatusResponse {
    var isSuccess: Bool {
        response == "True"
    }
}
