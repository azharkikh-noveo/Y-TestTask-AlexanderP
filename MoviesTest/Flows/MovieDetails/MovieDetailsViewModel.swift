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
    private let imagesHelper: ImagesHelper
    let movieDetailsService: MovieDetailsService
    private let movieDetailsSubject = BehaviorSubject<MovieDetailsModel?>(value: nil)
    var movieDetails: Driver<MovieDetailsModel?> {
        movieDetailsSubject.asDriver(onErrorJustReturn: nil)
    }
    private let posterURLSubject = BehaviorSubject<URL?>(value: nil)
    var posterURL: Driver<URL?> {
        posterURLSubject.asDriver(onErrorJustReturn: nil)
    }
    
    init(movieDetailsService: MovieDetailsService, imagesHelper: ImagesHelper, movieId: Int) {
        self.imagesHelper = imagesHelper
        self.movieDetailsService = movieDetailsService
        super.init()
        movieDetailsService.perform(input: movieId, success: { [weak self] details in
            guard let self = self,
                  let movieDetailsModel = MovieDetailsModel(from: details)
            else { return }
            
            self.movieDetailsSubject.onNext(movieDetailsModel)
            self.posterURLSubject.onNext(self.imagesHelper.posterUrl(for: movieDetailsModel))
        }, failure: defaultServiceFailure)
    }    
}
