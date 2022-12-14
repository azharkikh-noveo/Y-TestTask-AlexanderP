//
//  BaseViewModel.swift
//
//  Created by  Alexander Polyakov on 12.01.18.
//

import Foundation
import RxSwift
import RxCocoa

typealias ServiceFailure = ([ErrorWithMessageProtocol]) -> Void

class BaseViewModel  {
    final let disposeBag = DisposeBag()
    
    final let serviceErrorSubject = PublishSubject<ErrorWithMessageProtocol>()
    final var serviceError: Driver<ErrorWithMessageProtocol> {
        serviceErrorSubject.asDriver(onErrorJustReturn: ErrorWithTitleAndMessage.nullError)
    }

    final lazy private(set) var defaultServiceFailure: ServiceFailure = {
        { [weak self] errors in
            guard let `self` = self else {
                return
            }
            errors.forEach {
                self.serviceErrorSubject.onNext($0)
            }
        }
    }()
}
