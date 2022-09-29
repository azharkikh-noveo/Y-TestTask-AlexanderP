//
//  MoviesListViewModel.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class MoviesListViewModel: BaseViewModel {
    private(set) var items = [MovieItemViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    
    var updateUI: (() -> ())? {
        didSet {
            updateUI?()
        }
    }
    let moviesListService: MoviesListService
    let imagesHelper: ImagesHelper
    
    init(moviesListService: MoviesListService, imagesHelper: ImagesHelper) {
        self.moviesListService = moviesListService
        self.imagesHelper = imagesHelper
        super.init()
        obtainData()
    }
    
    func obtainData() {
        moviesListService.perform(input: ()) { moviesResult in
            self.items = moviesResult.results.compactMap {
                MovieModel(from: $0)
            }.map {
                MovieItemViewModel(item: $0, imagesHelper: self.imagesHelper)
            }
        } failure: { error in
            print("error!")
        }
    }
}
