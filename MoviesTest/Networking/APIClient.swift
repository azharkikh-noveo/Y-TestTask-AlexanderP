//
// NetworkingType.swift
//

import Foundation
import RxSwift

// MARK: - APIClientError enum definition

enum APIClientError: Error {
    case invalidUrl
    case noData
    case invalidData(Error)
    case noResponse
}

// MARK: - APIClient implementation

class APIClient: APIClientType {
    private let baseUrl: URL
    private let commonHeaders: [String: Any]
    private let responseProcessor: ResponseProcessorType
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(
        baseUrl: URL,
        commonHeaders: [String: Any] = [:],
        configuration: APIClientConfiguration,
        responseProcessor: ResponseProcessorType,
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.baseUrl = baseUrl
        self.commonHeaders = commonHeaders
        self.responseProcessor = responseProcessor
        self.session = session
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = configuration.dateParsingStrategy
        self.jsonDecoder = decoder
    }
    
    func fetch<T: Decodable>(
        path: String,
        method: HTTPMethod,
        params: [String: Any],
        body: Data?,
        additionalHeaders: [String: Any],
        responseProcessor: ResponseProcessorType?
    ) -> Single<T> {
        rawFetch(
            path: path,
            method: method,
            params: params,
            body: body,
            additionalHeaders: additionalHeaders,
            responseProcessor: responseProcessor
        )
        .flatMap { data, _ in
            guard let data = data else {
                return .error(APIClientError.noData)
            }
            
            do {
                let decodedObject = try self.jsonDecoder.decode(T.self, from: data)
                return .just(decodedObject)
            } catch {
                return .error(APIClientError.invalidData(error))
            }
        }
    }
    
    func rawFetch(
        path: String,
        method: HTTPMethod,
        params: [String: Any],
        body: Data?,
        additionalHeaders: [String: Any],
        responseProcessor: ResponseProcessorType?
    ) -> Single<Void> {
        rawFetch(
            path: path,
            method: method,
            params: params,
            body: body,
            additionalHeaders: additionalHeaders,
            responseProcessor: responseProcessor
        )
        .map { _, _ in }
    }
}

// MARK: - Private methods

private extension APIClient {
    func rawFetch(
        path: String,
        method: HTTPMethod,
        params: [String: Any],
        body: Data?,
        additionalHeaders: [String: Any],
        responseProcessor: ResponseProcessorType?
    ) -> Single<(Data?, URLResponse)> {
        let headers = commonHeaders.merging(additionalHeaders) { $1 }
        let request = createRequest(
            path: path,
            params: params,
            method: method,
            headers: headers,
            body: body
        )
        
        guard let request = request else {
            return .error(APIClientError.invalidUrl)
        }
        
        return session.rx.dataTask(
            for: request,
            responseProcessor: responseProcessor ?? self.responseProcessor
        )
    }
    
    func createRequest(
        path: String,
        params: [String: Any],
        method: HTTPMethod,
        headers: [String: Any],
        body: Data?
    ) -> URLRequest? {
        guard let url = createUrl(path: path, params: params) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers.forEach { request.setValue("\($1)", forHTTPHeaderField: $0) }
        
        return request
    }
    
    func createUrl(
        path: String,
        params: [String: Any]
    ) -> URL? {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        urlComponents.path = path
        let queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        
        return urlComponents.url
    }
}
