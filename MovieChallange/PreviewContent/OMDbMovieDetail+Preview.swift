//
//  OMDbMovie+Preview.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//
#if DEBUG
import Foundation

extension OMDbMovieDetail {
    static var preview: OMDbMovieDetail {
        .init(title: "Star Wars: Episode IV - A New Hope", year: "1977", imdbID: "tt0076759", plot: "The Imperial Forces, under orders from cruel Darth Vader, hold Princess Leia hostage in their efforts to quell the rebellion against the Galactic Empire. Luke Skywalker and Han Solo, captain of the Millennium Falcon, work together with the companionable droid duo R2-D2 and C-3PO to rescue the beautiful princess, help the Rebel Alliance and restore freedom and justice to the Galaxy.", director: "George Lucas", poster: "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg", type: .movie)
    }
}
#endif
