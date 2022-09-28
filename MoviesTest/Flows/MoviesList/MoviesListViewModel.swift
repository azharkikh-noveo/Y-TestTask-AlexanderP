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
    private(set) var items = [MovieItemViewModel]()
    var moviesListService: MoviesListService
    
    init(moviesListService: MoviesListService) {
        self.moviesListService = moviesListService
        super.init()
        foo()
    }
    
    func foo() {
        moviesListService.perform(input: ()) { moviesResult in
            print(moviesResult.results)
        } failure: { error in
            print("error!")
            print(error)
        }

    }
}
