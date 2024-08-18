//
//  OMDbMovie.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

struct OMDbMovieDetail: Decodable {
    let title, year, imdbID, plot, director, poster: String?
    var error: Error?
    
    private var errorString: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
        case plot = "Plot"
        case director = "Director"
        case errorString = "Error"
    }
    
    init(title: String, year: String, imdbID: String, plot: String, director: String, poster: String, error: Error? = nil) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.plot = plot
        self.director = director
        self.poster = poster
        self.error = error
        self.errorString = error?.localizedDescription
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.year = try container.decodeIfPresent(String.self, forKey: .year)
        self.imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        self.poster = try container.decodeIfPresent(String.self, forKey: .poster)
        self.plot = try container.decodeIfPresent(String.self, forKey: .plot)
        self.director = try container.decodeIfPresent(String.self, forKey: .director)
        self.errorString = try container.decodeIfPresent(String.self, forKey: .errorString)
        if let errorString {
            error = OMDbAPIError.apiError(errorString)
        }
    }
}

