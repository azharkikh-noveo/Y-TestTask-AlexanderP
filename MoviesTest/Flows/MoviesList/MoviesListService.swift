//
//  MoviesListService.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import Foundation

final class MoviesListService: OperationService<Int, MoviesResult> {
    override func createOperation(input: Int, success: @escaping OperationService<Int, MoviesResult>.ServiceSuccess, failure: @escaping ServiceFailure) -> Operation? {
        MoviesListOperation(page: input, success: success, failure: failure)
    }
}

fileprivate final class MoviesListOperation: APIOperation<MoviesResult> {
    init(page: Int, success: @escaping APIOperationSuccess, failure: @escaping ServiceFailure) {
        super.init(endpoint: .moviesList,
                   parameters: [AppConstants.apiKeyRequestKey: AppConstants.apiKey, "page": page],
                   headers: nil,
                   success: success,
                   failure: failure)
    }
}
