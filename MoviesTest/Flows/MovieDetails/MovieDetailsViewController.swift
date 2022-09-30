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
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var yearLabel = UILabel()
    private lazy var overviewLabel = UILabel()
//
//    override func loadView() {
//        view = scrollView
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.serviceError.drive(onNext: { [weak self] nextError in
            self?.present(error: nextError)
        }).disposed(by: disposeBag)
        
        viewModel.movieDetails.drive(onNext: { [weak self] item in
            guard let self = self,
                  let item = item
            else { return }
            
            self.imageView.sd_setImage(with: self.viewModel.imagesHelper.posterUrl(for: item))
            self.titleLabel.text = item.title
            self.yearLabel.text = item.year
            self.overviewLabel.text = item.overview
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        [imageView, titleLabel, yearLabel, overviewLabel].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
//            make.width.equalTo(imageView.snp.height).multipliedBy(500/750)
        }
    }
}
