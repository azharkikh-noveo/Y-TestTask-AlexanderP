//
//  MovieItemViewModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import Foundation

final class MovieItemViewModel: BaseViewModel {
    let item: MovieModel
    private let imagesHelper: ImagesHelper
    
    init(item: MovieModel, imagesHelper: ImagesHelper) {
        self.item = item
        self.imagesHelper = imagesHelper
    }
    
    var imageURL: URL? {
        imagesHelper.posterUrl(for: item)
    }
}
