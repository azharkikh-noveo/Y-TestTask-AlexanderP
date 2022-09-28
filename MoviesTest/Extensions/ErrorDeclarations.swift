//
//  ErrorWithMessage.swift
//

protocol ErrorWithMessageProtocol: Error {
    var message: String {get}
}

extension ErrorWithMessageProtocol {
    var message: String {
        return "Unknown error"
    }
}

struct ErrorWithMessage: ErrorWithMessageProtocol {
    private(set) var message: String
    
    init(message: String) {
        self.message = message
    }
}

struct UnknownError : ErrorWithMessageProtocol {}

struct NoDataError: ErrorWithMessageProtocol {
    var message: String {
        return "Server returned no data"
    }
}

struct NullError: ErrorWithMessageProtocol {
    var message: String { return "..." }
}

struct ErrorWithTitleAndMessage: ErrorWithMessageProtocol {
    var message: String
    var title: String
    init(title: String, message: String) {
        self.message = message
        self.title = title
    }
}

extension APIClientError {
    func toErrorWithTitleAndMessage() -> Error {
        switch self {
        case .invalidUrl:
            return ErrorWithTitleAndMessage(title: "Error", message: "Invalid URL")
        case .noData:
            return ErrorWithTitleAndMessage(title: "Error", message: "Server returned no data")
        case .noResponse:
            return ErrorWithTitleAndMessage(title: "Error", message: "Server did not respond in a timely manner")
        case .invalidData(_):
            return ErrorWithTitleAndMessage(title: "Error", message: "Server returned invalid data")
        }
    }
}
