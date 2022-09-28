//
//  MoviesListService.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import Foundation

final class MoviesListService: OperationService<Void, MoviesResult> {
    override func createOperation(input: Void, success: @escaping OperationService<Void, MoviesResult>.ServiceSuccess, failure: @escaping ServiceFailure) -> Operation? {
        MoviesListOperation(success: success, failure: failure)
    }
}

fileprivate final class MoviesListOperation: APIOperation<MoviesResult> {
    init(success: @escaping APIOperationSuccess, failure: @escaping ServiceFailure) {
        super.init(endpoint: .moviesList,
                   parameters: [AppConstants.apiKeyRequestKey: AppConstants.apiKey],
                   headers: nil,
                   success: success,
                   failure: failure)
    }
}
