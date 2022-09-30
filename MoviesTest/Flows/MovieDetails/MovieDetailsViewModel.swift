//
//  MovieDetailsViewModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import Foundation

final class MovieDetailsViewModel: BaseViewModel {
    var updateUI: (() -> ())? {
        didSet {
            updateUI?()
        }
    }
    
    let imagesHelper: ImagesHelper
    let movieDetailsService: MovieDetailsService
    
    init(movieDetailsService: MovieDetailsService, imagesHelper: ImagesHelper, movieId: Int) {
        self.imagesHelper = imagesHelper
        self.movieDetailsService = movieDetailsService
        super.init()
        movieDetailsService.perform(input: movieId, success: { details in
            
        }, failure: defaultServiceFailure)

    }
}
