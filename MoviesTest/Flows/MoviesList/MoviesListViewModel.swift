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
    let itemsSubject = PublishSubject<[MovieItemViewModel]>()
    var itemsDriver: Driver<[MovieItemViewModel]> {
        itemsSubject.asDriver(onErrorJustReturn: [])
    }
    
    private(set) var items = [MovieItemViewModel]()
    var selectItem: ((Int) -> ())?
    
    let moviesListService: MoviesListService
    let imagesHelper: ImagesHelper
    
    init(moviesListService: MoviesListService, imagesHelper: ImagesHelper) {
        self.moviesListService = moviesListService
        self.imagesHelper = imagesHelper
        super.init()
        obtainData()
    }
    
    func obtainData() {
        moviesListService.perform(input: (), success: { [weak self] moviesResult in
            guard let self = self else { return }
            let items = moviesResult.results.compactMap {
                MovieModel(from: $0)
            }.map {
                MovieItemViewModel(item: $0, imagesHelper: self.imagesHelper)
            }
            self.items += items
            self.itemsSubject.onNext(self.items)
        }, failure: defaultServiceFailure)
    }
}
