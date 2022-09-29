//
//  BaseViewController.swift
//

import UIKit
import RxSwift

class BaseViewController: UIViewController, ServiceErrorAlertPresenter {
    final let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    func bind() {}
}
