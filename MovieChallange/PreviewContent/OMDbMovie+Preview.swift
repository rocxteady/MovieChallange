//
//  OMDbMovie+Preview.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//
#if DEBUG
import Foundation

extension OMDbMovie {
    static var preview: OMDbMovie {
        .init(title: "Star Wars: Episode IV - A New Hope", year: "1977", imdbID: "tt0076759", poster: "https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg", type: .movie)
    }
}

extension [OMDbMovie] {
    static var preview: [OMDbMovie] {
        [
            .preview,
            .init(title: "Star Wars: Episode V - The Empire Strikes Back", year: "1980", imdbID: "tt0080684", poster: "https://m.media-amazon.com/images/M/MV5BYmU1NDRjNDgtMzhiMi00NjZmLTg5NGItZDNiZjU5NTU4OTE0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: Episode VI - Return of the Jedi", year: "1983", imdbID: "tt0086190", poster: "https://m.media-amazon.com/images/M/MV5BOWZlMjFiYzgtMTUzNC00Y2IzLTk1NTMtZmNhMTczNTk0ODk1XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: Episode VII - The Force Awakens", year: "2015", imdbID: "tt2488496", poster: "https://m.media-amazon.com/images/M/MV5BOTAzODEzNDAzMl5BMl5BanBnXkFtZTgwMDU1MTgzNzE@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: Episode I - The Phantom Menace", year: "1999", imdbID: "tt0120915", poster: "https://m.media-amazon.com/images/M/MV5BYTRhNjcwNWQtMGJmMi00NmQyLWE2YzItODVmMTdjNWI0ZDA2XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: Episode III - Revenge of the Sith", year: "2005", imdbID: "tt0121766", poster: "https://m.media-amazon.com/images/M/MV5BNTc4MTc3NTQ5OF5BMl5BanBnXkFtZTcwOTg0NjI4NA@@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: Episode II - Attack of the Clones", year: "2002", imdbID: "tt0121765", poster: "https://m.media-amazon.com/images/M/MV5BMDAzM2M0Y2UtZjRmZi00MzVlLTg4MjEtOTE3NzU5ZDVlMTU5XkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_SX300.jpg", type: .movie),
            .init(title: "Rogue One: A Star Wars Story", year: "2016", imdbID: "tt3748528", poster: "https://m.media-amazon.com/images/M/MV5BMjEwMzMxODIzOV5BMl5BanBnXkFtZTgwNzg3OTAzMDI@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: Episode VIII - The Last Jedi", year: "2017", imdbID: "tt2527336", poster: "https://m.media-amazon.com/images/M/MV5BMjQ1MzcxNjg4N15BMl5BanBnXkFtZTgwNzgwMjY4MzI@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Trek", year: "2009", imdbID: "tt0796366", poster: "https://m.media-amazon.com/images/M/MV5BMjE5NDQ5OTE4Ml5BMl5BanBnXkFtZTcwOTE3NDIzMw@@._V1_SX300.jpg", type: .movie)
        ]
    }
    
    static var preview2: [OMDbMovie] {
        [
            .init(title: "Star Wars: Episode IX - The Rise of Skywalker", year: "2019", imdbID: "tt2527338", poster: "https://m.media-amazon.com/images/M/MV5BMDljNTQ5ODItZmQwMy00M2ExLTljOTQtZTVjNGE2NTg0NGIxXkEyXkFqcGdeQXVyODkzNTgxMDg@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Trek Into Darkness", year: "2013", imdbID: "tt1408101", poster: "https://m.media-amazon.com/images/M/MV5BMTk2NzczOTgxNF5BMl5BanBnXkFtZTcwODQ5ODczOQ@@._V1_SX300.jpg", type: .movie),
            .init(title: "A Star Is Born", year: "2018", imdbID: "tt1517451", poster: "https://m.media-amazon.com/images/M/MV5BNmE5ZmE3OGItNTdlNC00YmMxLWEzNjctYzAwOGQ5ODg0OTI0XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", type: .movie),
            .init(title: "Solo: A Star Wars Story", year: "2018", imdbID: "tt3778644", poster: "https://m.media-amazon.com/images/M/MV5BOTM2NTI3NTc3Nl5BMl5BanBnXkFtZTgwNzM1OTQyNTM@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Trek Beyond", year: "2016", imdbID: "tt2660888", poster: "https://m.media-amazon.com/images/M/MV5BNDc2YThlMTgtN2M3Yi00YzkxLWE4MDQtMWJmYmZiNTNjNjJlXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Trek: Discovery", year: "2017–2024", imdbID: "tt5171438", poster: "https://m.media-amazon.com/images/M/MV5BODU1MmVmMTYtNzNhNi00NjRlLTljMWItZmFhMWNmYTNhYThiXkEyXkFqcGdeQXVyMTU5OTc2NTk@._V1_SX300.jpg", type: .series),
            .init(title: "Star Trek: The Next Generation", year: "1987–1994", imdbID: "tt0092455", poster: "https://m.media-amazon.com/images/M/MV5BOWFhYjE4NzMtOWJmZi00NzEyLTg5NTctYmIxMTU1ZDIxMDAyXkEyXkFqcGdeQXVyNTE1NjY5Mg@@._V1_SX300.jpg", type: .series),
            .init(title: "Star Trek: First Contact", year: "1996", imdbID: "tt0117731", poster: "https://m.media-amazon.com/images/M/MV5BYzMzZmE3MTItODYzYy00YWI5LWFkNWMtZTY5NmU2MDkxYWI1XkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Trek II: The Wrath of Khan", year: "1982", imdbID: "tt0084726", poster: "https://m.media-amazon.com/images/M/MV5BNmZiZmM2OTUtZDlmOC00YzYyLThkMGEtZWFkMjJmM2EwZDVkXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_SX300.jpg", type: .movie),
            .init(title: "Star Wars: The Clone Wars", year: "2008–2020", imdbID: "tt0458290", poster: "https://m.media-amazon.com/images/M/MV5BZWFlNzRmOTItZjY1Ni00ZjZkLTk5MDgtOGFhOTYzNWFhYzhmXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_SX300.jpg", type: .series)
        ]
    }
}
#endif
