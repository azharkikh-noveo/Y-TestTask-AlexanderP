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
    let itemsSubject = BehaviorSubject<[MovieItemViewModel]>(value: [])
    var itemsDriver: Driver<[MovieItemViewModel]> {
        itemsSubject.asDriver(onErrorJustReturn: [])
    }
    var page = 1
    let resultsPerPage = 20
    
    var selectItem: ((Int) -> Void)?
    
    private let moviesListService: MoviesListService
    private let imagesHelper: ImagesHelper
    
    init(moviesListService: MoviesListService, imagesHelper: ImagesHelper) {
        self.moviesListService = moviesListService
        self.imagesHelper = imagesHelper
        super.init()
        obtainData()
    }
    
    private var totalPages: Int?
    
    func obtainData() {
        if let totalPages = totalPages {
            if page > totalPages {
                return
            }
        }
        moviesListService.perform(input: page, success: { [weak self] moviesResult in
            guard let self = self else { return }
            let items = moviesResult.results.compactMap {
                MovieModel(from: $0)
            }.map {
                MovieItemViewModel(item: $0, imagesHelper: self.imagesHelper)
            }
            let allItems = (try! self.itemsSubject.value()) + items
            self.itemsSubject.onNext(allItems)
        }, failure: defaultServiceFailure)
    }
}
