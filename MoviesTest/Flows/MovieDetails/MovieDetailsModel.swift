//
//  MovieDetailsModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import Foundation

struct MovieDetailsModel: MovieWithPoster {
    let title: String
    let posterPath: String
    let year: String
    let overview: String
    
    init?(from dto: MovieDetails) {
        guard let title = dto.title,
              let posterPath = dto.posterPath,
              let releaseDate = dto.releaseDate,
              let overview = dto.overview
        else { return nil }
        self.title = title
        self.posterPath = posterPath
        self.year = String(releaseDate.prefix(4))
        self.overview = overview
    }
}
