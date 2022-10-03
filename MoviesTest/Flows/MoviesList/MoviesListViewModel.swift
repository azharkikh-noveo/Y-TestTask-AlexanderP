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
    let resultsPerPage = 20
    
    /// 'value()' of that subject never throws
    let itemsSubject = BehaviorSubject<[MovieItemViewModel]>(value: [])
    var itemsSubjectCurrentValue: [MovieItemViewModel] {
        // swiftlint:disable force_try
        try! itemsSubject.value()
        // swiftlint:enable force_try
    }
    var items: Driver<[MovieItemViewModel]> {
        itemsSubject.asDriver(onErrorJustReturn: [])
    }
    
    var selectItem: ((Int) -> Void)?
    
    func onNextPage() {
        if totalPages != nil {
            // swiftlint:disable force_unwrapping
            guard page < totalPages! else { return }
            // swiftlint:enable force_unwrapping
        }
        page += 1
        obtainData()
    }
    
    private let moviesListService: MoviesListService
    private let imagesHelper: ImagesHelper
    private(set) var page = 0
    // initialized on first fetch
    private var totalPages: Int?
    
    init(moviesListService: MoviesListService, imagesHelper: ImagesHelper) {
        self.moviesListService = moviesListService
        self.imagesHelper = imagesHelper
        super.init()
        onNextPage()
    }
    
    private func obtainData() {
        moviesListService.perform(input: page, success: { [weak self] moviesResult in
            guard let self = self else { return }
            self.totalPages = moviesResult.totalPages
            
            let items = moviesResult.results.compactMap {
                MovieModel(from: $0)
            }.map {
                MovieItemViewModel(item: $0, imagesHelper: self.imagesHelper)
            }
            
            let allItems = self.itemsSubjectCurrentValue + items
            self.itemsSubject.onNext(allItems)
        }, failure: defaultServiceFailure)
    }
}
