//
//  ConfigurationService.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 29.09.2022.
//

import Foundation

final class ConfigurationService: OperationService<Void, Configuration> {
    override func createOperation(input: Void, success: @escaping OperationService<Void, Configuration>.ServiceSuccess, failure: @escaping ServiceFailure) -> Operation? {
        ConfigurationOperation(success: success, failure: failure)
    }
}

final private class ConfigurationOperation: APIOperation<Configuration> {
    init(success: @escaping APIOperationSuccess, failure: @escaping ServiceFailure) {
        super.init(endpoint: .configuration,
                   parameters: [AppConstants.apiKeyRequestKey: AppConstants.apiKey],
                   headers: nil,
                   success: success,
                   failure: failure)
    }
}
