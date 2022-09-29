//
//  MovieItemViewModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import Foundation

final class MovieItemViewModel: BaseViewModel {
    let item: MovieModel
    init(item: MovieModel) {
        self.item = item
    }
}
