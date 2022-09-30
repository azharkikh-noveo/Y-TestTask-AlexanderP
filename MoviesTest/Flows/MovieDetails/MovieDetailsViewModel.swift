//
//  MovieDetailsViewModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailsViewModel: BaseViewModel {
    var updateUI: (() -> ())? {
        didSet {
            updateUI?()
        }
    }
    
    let imagesHelper: ImagesHelper
    let movieDetailsService: MovieDetailsService
    private let movieDetailsSubject = PublishSubject<MovieDetailsModel?>()
    var movieDetails: Driver<MovieDetailsModel?> {
        movieDetailsSubject.asDriver(onErrorJustReturn: nil)
    }
    
    init(movieDetailsService: MovieDetailsService, imagesHelper: ImagesHelper, movieId: Int) {
        self.imagesHelper = imagesHelper
        self.movieDetailsService = movieDetailsService
        super.init()
        movieDetailsService.perform(input: movieId, success: { [weak self] details in
            self?.movieDetailsSubject.onNext(MovieDetailsModel(from: details))
        }, failure: defaultServiceFailure)

    }
}
