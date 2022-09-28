//
//  BaseViewModel.swift
//  ILSS
//
//  Created by  Alexander Polyakov on 12.01.18.
//  Copyright © 2018 madbrains. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias ServiceFailure = ([ErrorWithMessageProtocol]) -> ()

class BaseViewModel  {
    final let disposeBag = DisposeBag()
    
    final let serviceErrorSubject = PublishSubject<ErrorWithMessageProtocol>()
    final var serviceError: Driver<ErrorWithMessageProtocol> {
        serviceErrorSubject.asDriver(onErrorJustReturn: ErrorWithTitleAndMessage.nullError)
    }

    final lazy private(set) var defaultServiceFailure: ServiceFailure = {
        return { [weak self] errors in
            guard let `self` = self else {
                return
            }
            errors.forEach {
                print($0.message)
                self.serviceErrorSubject.onNext($0)
            }
        }
    }()
}
