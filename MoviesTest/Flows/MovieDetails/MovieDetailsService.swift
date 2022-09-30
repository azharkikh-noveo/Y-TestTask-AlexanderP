//
//  MovieDetailsService.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import Foundation

final class MovieDetailsService: OperationService<Int, MovieDetails> {
    override func createOperation(input: Int, success: @escaping OperationService<Int, MovieDetails>.ServiceSuccess, failure: @escaping ServiceFailure) -> Operation? {
        MovieDetailsOperation(movieId: input, success: success, failure: failure)
    }
}

fileprivate final class MovieDetailsOperation: APIOperation<MovieDetails> {
    init(movieId: Int, success: @escaping APIOperationSuccess, failure: @escaping ServiceFailure) {
        super.init(endpoint: .movieDetails(movieId: movieId),
                   parameters: [AppConstants.apiKeyRequestKey: AppConstants.apiKey],
                   headers: nil,
                   success: success,
                   failure: failure)
    }
}
