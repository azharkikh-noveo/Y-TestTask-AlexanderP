//
//  MovieDetailsViewController.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import Foundation

final class MovieDetailsViewController: BaseViewController {
    var viewModel: MovieDetailsViewModel! {
        didSet {
            viewModel.updateUI = { [weak self] in
                print(self as Any)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.serviceError.drive(onNext: { [weak self] nextError in
            self?.present(error: nextError)
        }).disposed(by: disposeBag)
    }
}
