//
//  MoviesListService.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import Foundation

final class MoviesListService: OperationService<Void, [Movie]> {
    override func createOperation(input: Void, success: @escaping OperationService<Void, [Movie]>.ServiceSuccess, failure: @escaping ServiceFailure) -> Operation? {
        MoviesListOperation(success: success, failure: failure)
    }
}

fileprivate final class MoviesListOperation: APIOperation<[Movie]> {
    init(success: @escaping APIOperationSuccess, failure: @escaping ServiceFailure) {
        super.init(endpoint: .moviesList,
                   parameters: [AppConstants.apiKeyRequestKey: AppConstants.apiKey],
                   headers: nil,
                   success: success,
                   failure: failure)
    }
}
