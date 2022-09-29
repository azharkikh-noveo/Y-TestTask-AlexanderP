//
//  ConfigurationModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 29.09.2022.
//

import Foundation

struct ConfigurationModel {
    let baseUrl: String
    let posterSizes: [String]
    
    init?(from dto: Configuration) {
        guard let baseUrl = dto.images?.baseUrl,
              let posterSizes = dto.images?.posterSizes
        else { return nil }
        self.baseUrl = baseUrl
        self.posterSizes = posterSizes
    }
}
