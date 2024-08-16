//
//  OMDbMovie.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

enum OMDbContenType: String, Decodable {
    case movie
    case series
}

struct OMDbMovie: Decodable {
    let title, year, imdbID, poster: String
    let type: OMDbContenType

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
