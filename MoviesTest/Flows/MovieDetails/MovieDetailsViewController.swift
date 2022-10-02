//
//  MovieDetailsViewController.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import UIKit
import SnapKit

final class MovieDetailsViewController: BaseViewController {
    var viewModel: MovieDetailsViewModel!
    
    private lazy var scrollView = UIScrollView()
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var yearLabel = UILabel()
    private lazy var overviewLabel = UILabel()
    
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
            
            self.titleLabel.text = item.title
            self.yearLabel.text = item.year
            self.overviewLabel.text = item.overview
        }).disposed(by: disposeBag)
        
        viewModel.posterURL.drive(onNext: { [weak self] url in
            guard let self = self,
                  let url = url
            else { return }
            
            self.imageView.sd_setImage(with: url
                                       , placeholderImage: nil
                                       , options: [.retryFailed, .highPriority])
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: scrollableContentHeight)
    }
    
    private var scrollableContentHeight: CGFloat {
        0 + imageView.frame.height + 30
        + titleLabel.intrinsicContentSize.height + 20
        + yearLabel.frame.height + 20
        + overviewLabel.intrinsicContentSize.height + 20
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.numberOfLines = 0
        overviewLabel.numberOfLines = 0
        scrollView.bounces = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        [imageView, titleLabel, yearLabel, overviewLabel].forEach { scrollView.addSubview($0) }
        
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 750/500, constant: 1).isActive = true
        imageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide)
            make.left.equalTo(scrollView.frameLayoutGuide)
            make.right.equalTo(scrollView.frameLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalTo(scrollView.frameLayoutGuide).offset(20)
            make.right.equalTo(scrollView.frameLayoutGuide).inset(20)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(scrollView.frameLayoutGuide).offset(20)
            make.right.equalTo(scrollView.frameLayoutGuide).inset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(20)
            make.left.equalTo(scrollView.frameLayoutGuide).offset(20)
            make.right.equalTo(scrollView.frameLayoutGuide).inset(20)
            make.bottom.equalTo(scrollView.contentLayoutGuide).inset(20)
        }
    }
}
