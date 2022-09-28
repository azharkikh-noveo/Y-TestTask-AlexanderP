//
// URLSession+Rx.swift
// Created for Home Control in 2021
//

import Foundation
import RxSwift

extension Reactive where Base == URLSession {
    func dataTask(
        for request: URLRequest
    ) -> Single<(Data?, URLResponse)> {
        Single.create { single in
            base.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let response = response else {
                    single(.failure(APIClientError.noResponse))
                    return
                }
                
                single(.success((data, response)))
            }.resume()
            
            return Disposables.create()
        }
    }
    
    func dataTask(
        for request: URLRequest,
        responseProcessor: ResponseProcessorType
    ) -> Single<(Data?, URLResponse)> {
        dataTask(for: request)
            .flatMap { data, response in
                if let error = responseProcessor.extractError(from: response) {
                    return .error(error)
                }
                
                return .just((data, response))
            }
    }
    
    func data(from url: URL) -> Single<Data> {
        let request = URLRequest(url: url)
        
        return dataTask(for: request)
            .flatMap { data, _ in
                guard let data = data else {
                    return .error(APIClientError.noData)
                }
                
                return .just(data)
            }
    }
}
