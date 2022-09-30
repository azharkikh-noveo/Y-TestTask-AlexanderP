//
//  ImagesHelper.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 29.09.2022.
//

import Foundation

final class ImagesHelper {
    private static let preferredPosterSizes: [String] = ["w500", "w780", "original"]

    private let configurationModel: ConfigurationModel
    private var posterSize = ""
    
    /// Failing from that initializer means error with configuration API
    init?(configurationModel: ConfigurationModel) {
        if configurationModel.posterSizes.isEmpty {
            return nil
        }
        
        self.configurationModel = configurationModel
        
        for preferredPosterSize in type(of: self).preferredPosterSizes {
            if configurationModel.posterSizes.contains(where: { $0 == preferredPosterSize }) {
                posterSize = preferredPosterSize
                return
            }
        }
        if let size = configurationModel.posterSizes.first {
            posterSize = size
        } else {
            return nil
        }
    }

    func posterUrl(for movie: MovieWithPoster) -> URL? {
        let string = configurationModel.baseUrl + posterSize + movie.posterPath
        return URL(string: string)
    }

}
