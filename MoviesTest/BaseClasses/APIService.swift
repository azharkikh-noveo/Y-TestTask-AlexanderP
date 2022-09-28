//
//  APIService.swift
//
//  Created by  Alexander Polyakov on 18.01.18.
//

typealias ServiceFailure = ([ErrorWithMessageProtocol]) -> ()

class APIService<Input, Output> {
    typealias ServiceSuccess = (Output) -> ()
    
    func perform(input: Input, success: @escaping ServiceSuccess, failure: @escaping ServiceFailure) {
        fatalError("Pure virtual function call: must implement perform(input:success:failure:)")
    }
    
    class func processErrors(handler: @escaping ServiceFailure,
                             rootError: Error?,
                             apiErrors: [String?]? = nil) -> Bool {
        if rootError != nil {
            handler([UnknownError()])
            return true
        }
        if let apiErrors = apiErrors {
            
            handler(apiErrors.compactMap{ $0 }.map({ (errorMessage) -> ErrorWithMessage in
                ErrorWithMessage(message: errorMessage)
            }))
            return true
        }
        return false
    }
}
