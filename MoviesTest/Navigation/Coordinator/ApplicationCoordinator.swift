//
//  ApplicationCoordinator.swift
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    private weak var window: UIWindow?
    
    init(window: UIWindow) {
        super.init()
        self.window = window
    }
    
    override func start() {
        startMoviesList()
    }
    
    private func startMoviesList() {
        let moviesListViewController = MoviesListViewController()
        let viewModel = MoviesListViewModel(moviesListService: MoviesListService())
        moviesListViewController.viewModel = viewModel
        window?.rootViewController = moviesListViewController
//        let tabBarController = UITabBarController()
//        self.window?.rootViewController = tabBarController
//        let coordinator = MainFlowCoordinator(tabBar: tabBarController)
//        coordinator.flowCompletion = { [weak self] coordinator in
//            self?.startAuth()
//            self?.removeDependency(coordinator)
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
}
