//
//  MovieModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 29.09.2022.
//

import Foundation

protocol MovieWithPoster {
    var posterPath: String { get }
}

struct MovieModel: MovieWithPoster {
    let id: Int
    let title: String
    let posterPath: String
    let year: String
    
    init?(from dto: Movie) {
        guard let id = dto.id,
              let title = dto.title,
              let posterPath = dto.posterPath,
              let releaseDate = dto.releaseDate
        else { return nil }
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.year = String(releaseDate.prefix(4))
    }
}

