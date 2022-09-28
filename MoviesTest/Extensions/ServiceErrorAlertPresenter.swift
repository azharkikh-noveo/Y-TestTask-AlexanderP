//
//  ServiceErrorAlertPresenter.swift
//
//  Created by  Alexander Polyakov on 16.02.18.
//

import Foundation
import UIKit

protocol ServiceErrorAlertPresenter: AnyObject {
    func present(error withMessage: ErrorWithMessageProtocol)
    func present(error withTitleAndMessage: ErrorWithTitleAndMessage)
}

fileprivate struct QueueHolder {
    private init() {}
    static let instance = QueueHolder()
    let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

extension ServiceErrorAlertPresenter where Self: UIViewController {
    private var isPresenting: Bool {
        get {
            return QueueHolder.instance.operationQueue.isSuspended
        }
        set {
            QueueHolder.instance.operationQueue.isSuspended = newValue
        }
    }
    
    func present(error: Error) {
        if let error = error as? ErrorWithTitleAndMessage {
            present(error: error)
        }
        else if let error = error as? ErrorWithMessageProtocol {
            present(error: error)
        }
    }

    func present(error withMessage: ErrorWithMessageProtocol) {
        guard !isPresenting else {
            enqueue { [weak self] in
                self?.present(error: withMessage)
            }
            return
        }
        isPresenting = true
        let alertController = UIAlertController(title: withMessage.message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: actionDismiss))
        present(alertController, animated: true, completion: nil)
    }

    func present(error withTitleAndMessage: ErrorWithTitleAndMessage) {
        guard !isPresenting else {
            enqueue { [weak self] in
                self?.present(error: withTitleAndMessage)
            }
            return
        }
        isPresenting = true
        let alertController = UIAlertController(title: withTitleAndMessage.title, message: withTitleAndMessage.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: actionDismiss))
        present(alertController, animated: true, completion: nil)
    }

    private func actionDismiss(_ sender: UIAlertAction) {
        isPresenting = false
    }

    private func enqueue(_ action: @escaping () -> ()) {
        QueueHolder.instance.operationQueue.addOperation {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
