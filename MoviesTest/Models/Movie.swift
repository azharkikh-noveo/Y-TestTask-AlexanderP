//
//  Movie.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 27.09.2022.
//

import Foundation

struct Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
        adult = try values.decode(Bool?.self, forKey: .adult)
        overview = try values.decode(String?.self, forKey: .overview)
        releaseDate = try values.decode(String?.self, forKey: .releaseDate)
        genreIds = try values.decode([Int]?.self, forKey: .genreIds)
        id = try values.decode(Int?.self, forKey: .id)
        originalTitle = try values.decode(String?.self, forKey: .originalTitle)
        originalLanguage = try values.decode(String?.self, forKey: .originalLanguage)
        title = try values.decode(String?.self, forKey: .title)
        backdropPath = try values.decode(String?.self, forKey: .backdropPath)
        popularity = try values.decode(Double?.self, forKey: .popularity)
        voteCount = try values.decode(Int?.self, forKey: .voteCount)
        video = try values.decode(Bool?.self, forKey: .video)
        voteAverage = try values.decode(Double?.self, forKey: .voteAverage)
    }

    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
}
