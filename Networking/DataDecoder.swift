//
//  DataDecoder.swift
//
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

//DataDecoder is a protocol that is used to decode data to a specific type.
protocol DataDecoder {
    /// Decodes the given data to the specified type.
    /// - Parameters:
    ///  - type: The type to decode the data to.
    ///  - data: The data to decode.
    ///  - Returns: The decoded object of the specified type.
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

//JSONDataDecoder is a concrete implementation of DataDecoder that decodes JSON data.
struct JSONDataDecoder: DataDecoder {
    /// Initializes a new JSONDataDecoder.
    init() {}
    
    /// Decodes the given JSON data to the specified type.
    /// - Parameters:
    /// - type: The type to decode the data to.
    /// - data: The JSON data to decode.
    /// - Returns: The decoded object of the specified type.
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
