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

