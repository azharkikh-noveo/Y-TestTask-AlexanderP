//
//  ErrorWithMessage.swift
//

protocol ErrorWithMessageProtocol: Error {
    var message: String { get }
}

extension ErrorWithMessageProtocol {
    var message: String { L10n.nullError }
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
        ErrorWithTitleAndMessage(title: L10n.error, message: L10n.nullError)
    }
    
    static var noDataError: ErrorWithTitleAndMessage {
        ErrorWithTitleAndMessage(title: L10n.error, message: L10n.noDataError)
    }
    
    static var invalidURLError: ErrorWithTitleAndMessage {
        ErrorWithTitleAndMessage(title: L10n.error, message: L10n.invalidURLError)
    }
}
