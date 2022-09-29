//
//  MoviesListCoordinator.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 30.09.2022.
//

import UIKit

final class MoviesListCoordinator: BaseCoordinator {
    let imagesHelper: ImagesHelper
    private weak var window: UIWindow?
    
    init(window: UIWindow?, imagesHelper: ImagesHelper) {
        self.imagesHelper = imagesHelper
        self.window = window
        super.init()
    }
    
    override func start() {
        let navigationController = BaseNavigationController()
        let moviesListViewController = MoviesListViewController()
        let viewModel = MoviesListViewModel(moviesListService: MoviesListService(), imagesHelper: imagesHelper)
        moviesListViewController.viewModel = viewModel
        navigationController.viewControllers = [moviesListViewController]
        window?.rootViewController = navigationController
    }
}
