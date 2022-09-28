//
//  APIOperation.swift
//
//  Created by Alexander Polyakov on 06.07.2018.
//

import Foundation
import Alamofire

struct APIEndpoint {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    let method: Method
    let path: String

    fileprivate init(_ method: Method, _ path: String) {
        self.method = method
        self.path = path
    }
}

extension APIEndpoint: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: path) else {
            throw AFError.invalidURL(url: self)
        }
        return url
    }
}

extension APIEndpoint {
    static var moviesList: APIEndpoint {
        APIEndpoint(.get, AppConstants.moviesListURL)
    }
}

class APIOperation<Output: Decodable>: Operation {
    typealias APIOperationSuccess = (Output) -> ()

    let endpoint: APIEndpoint
    let headers: HTTPHeaders?
    let parameters: Parameters?
    let failure: ServiceFailure
    let success: APIOperationSuccess
    
    init(endpoint: APIEndpoint, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping APIOperationSuccess, failure: @escaping ServiceFailure) {
        self.endpoint = endpoint
        self.parameters = parameters
        self.headers = headers
        self.success = success
        self.failure = failure
        super.init()
    }
    
    func URL(with endpoint: APIEndpoint) -> URLConvertible {
        return endpoint
    }
    
    func createRequest() -> Alamofire.DataRequest {
        return AF.request(URL(with: endpoint), method: endpoint.method.asAlamofireMethod(), parameters: parameters, encoding: URLEncoding.default, headers: headers)
    }
    
    final override func main() {
        let success = self.success
        let failure = self.failure
        let request = createRequest()
        request.response(queue: DispatchQueue.global()) { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    failure([ErrorWithTitleAndMessage.noDataError])
                    return
                }
                do {
                    let parsed: Output = try JSONDecoder().decode(Output.self, from: data)
                    print(parsed)
                }
                catch {
                    print("catch")
                    print(error)
                }
                guard let parsedResult: Output = try? JSONDecoder().decode(Output.self, from: data) else {
                    failure([ErrorWithTitleAndMessage.noDataError])
                    return
                }
                success(parsedResult)
                return
            case .failure(let afError):
                if afError.isInvalidURLError {
                    failure([ErrorWithTitleAndMessage.invalidURLError])
                    return
                }
                failure([ErrorWithTitleAndMessage.nullError])
                return
            }
        }
    }
}

extension APIEndpoint.Method {
    func asAlamofireMethod() -> Alamofire.HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}
