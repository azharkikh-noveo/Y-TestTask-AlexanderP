//
//  MovieDetails.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 27.09.2022.
//

import Foundation

struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct ProductionCompany: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    let name: String?
    let id: Int?
    let logoPath: String?
    let originCountry: String?
}

struct ProductionCountry: Codable {
    let iso_3166_1: String?
    let name: String?
}

struct SpokenLanguage: Codable {
    let iso_639_1: String?
    let name: String?
}

struct MovieDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.budget = try container.decodeIfPresent(Int.self, forKey: .budget)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.productionCompanies = try container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies)
        self.productionCountries = try container.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.revenue = try container.decodeIfPresent(Int.self, forKey: .revenue)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.spokenLanguages = try container.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguages)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.video = try container.decodeIfPresent(Bool.self, forKey: .video)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }
    
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let id: Int?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
