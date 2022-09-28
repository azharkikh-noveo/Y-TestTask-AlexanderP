//
//  ErrorWithMessage.swift
//

protocol ErrorWithMessageProtocol: Error {
    var message: String { get }
}

extension ErrorWithMessageProtocol {
    var message: String { "Unknown error" }
}

struct ErrorWithMessage: ErrorWithMessageProtocol {
    private(set) var message: String
    
    init(message: String) {
        self.message = message
    }
}

struct ErrorWithTitleAndMessage: ErrorWithMessageProtocol {
    var message: String
    var title: String
    init(title: String, message: String) {
        self.message = message
        self.title = title
    }
    
    static var nullError: ErrorWithTitleAndMessage {
        ErrorWithTitleAndMessage(title: "Error", message: "Unknown error")
    }
    
    static var noDataError: ErrorWithTitleAndMessage {
        ErrorWithTitleAndMessage(title: "Error", message: "Server returned no data")
    }
    
    static var invalidURLError: ErrorWithTitleAndMessage {
        ErrorWithTitleAndMessage(title: "Error", message: "Invalid URL")
    }
}
