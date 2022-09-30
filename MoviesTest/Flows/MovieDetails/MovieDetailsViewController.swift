//
//  MovieDetailsViewController.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import UIKit
import SnapKit

final class MovieDetailsViewController: BaseViewController {
    var viewModel: MovieDetailsViewModel! {
        didSet {
            viewModel.updateUI = { [weak self] in
                print(self as Any)
            }
        }
    }
    
    private lazy var scrollView = UIScrollView()
    private lazy var theImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var yearLabel = UILabel()
    private lazy var overviewLabel = UILabel()
    
    override func loadView() {
        view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.serviceError.drive(onNext: { [weak self] nextError in
            self?.present(error: nextError)
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}
