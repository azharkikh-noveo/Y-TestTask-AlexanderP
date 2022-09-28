//
//  OperationService.swift
//
//  Created by Alexander Polyakov on 06.07.2018.
//

import Foundation

class OperationService<Input, Output: Decodable> {
    typealias ServiceSuccess = (Output) -> ()
    
    final let operationQueue = OperationQueue()
    
    final func perform(input: Input, success: @escaping ServiceSuccess, failure: @escaping ServiceFailure) {
        guard let operation = createOperation(input: input, success: success, failure: failure) else {
            failure([ErrorWithTitleAndMessage(title: "Error", message: "Operation not defined")])
            return
        }
        operationQueue.addOperation(operation)
    }
    
    func createOperation(input: Input, success: @escaping ServiceSuccess, failure: @escaping ServiceFailure) -> Operation? {
        return nil
    }
}
