//
//  OMDbMovie.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbMovieDetail: Decodable, StatusResponse {
    let title, year, imdbID, plot, director, poster: String
    let type: OMDbContenType
    let response: String
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case plot
        case director
        case response = "Response"
        case error = "Error"
    }
    
    init(title: String, year: String, imdbID: String, plot: String, director: String, poster: String, type: OMDbContenType, response: String = "True", error: String? = nil) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.plot = plot
        self.director = director
        self.poster = poster
        self.type = type
        self.response = response
        self.error = error
    }
}

