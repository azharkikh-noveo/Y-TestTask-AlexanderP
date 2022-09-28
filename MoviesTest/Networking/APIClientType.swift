//
// APIClientType.swift
// Created for Home Control in 2021
//

import Foundation
import RxSwift

// MARK: - HTTPMethod enum definition

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case post = "POST"
    case delete = "DELETE"
}

// MARK: - ResponseProcessorType definition

public protocol ResponseProcessorType: AnyObject {
    func extractError(from response: URLResponse) -> Error?
}

// MARK: - APIClientConfiguration definition

struct APIClientConfiguration {
    let dateParsingStrategy: JSONDecoder.DateDecodingStrategy
}

// MARK: - APIClientType definition

public protocol APIClientType {
    func fetch<T: Decodable>(
        path: String,
        method: HTTPMethod,
        params: [String: Any],
        body: Data?,
        additionalHeaders: [String: Any],
        responseProcessor: ResponseProcessorType?
    ) -> Single<T>
    
    func rawFetch(
        path: String,
        method: HTTPMethod,
        params: [String: Any],
        body: Data?,
        additionalHeaders: [String: Any],
        responseProcessor: ResponseProcessorType?
    ) -> Single<Void>
}

// MARK: - APIClientType convenience access extensions

public extension APIClientType {
    func fetch<T: Decodable>(
        path: String,
        method: HTTPMethod,
        params: [String: Any] = [:],
        body: Data? = nil,
        additionalHeaders: [String: Any] = [:],
        responseProcessor: ResponseProcessorType? = nil
    ) -> Single<T> {
        fetch(
            path: path,
            method: method,
            params: params,
            body: body,
            additionalHeaders: additionalHeaders,
            responseProcessor: responseProcessor
        )
    }
    
    func rawFetch(
        path: String,
        method: HTTPMethod,
        params: [String: Any] = [:],
        body: Data? = nil,
        additionalHeaders: [String: Any] = [:],
        responseProcessor: ResponseProcessorType? = nil
    ) -> Single<Void> {
        rawFetch(
            path: path,
            method: method,
            params: params,
            body: body,
            additionalHeaders: additionalHeaders,
            responseProcessor: responseProcessor
        )
    }
}
