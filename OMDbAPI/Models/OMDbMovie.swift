//
//  OMDbMovie.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbMovie: Decodable, Equatable {
    let title, year, imdbID, poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
    
    init(title: String, year: String, imdbID: String, poster: String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.poster = poster
    }
}

