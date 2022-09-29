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
        let errorVC = ErrorViewController()
        self.window?.rootViewController = errorVC
        
        let configurationService = ConfigurationService()
        configurationService.perform(input: ()) { [weak self] configuration in
            guard let self = self else { return }
            
            guard let configuration = ConfigurationModel(from: configuration),
                  let imagesHelper = ImagesHelper(configurationModel: configuration)
            else {
                DispatchQueue.main.async {
                    (self.window?.rootViewController as? ErrorViewController)?.errors = [ErrorWithTitleAndMessage(title: "Error", message: "Error obtaining the configuration")]
                }
                return
            }
            DispatchQueue.main.async {
                self.startMoviesList(imagesHelper: imagesHelper)
            }
        } failure: { [weak self] errors in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let errorVC = ErrorViewController()
                self.window?.rootViewController = errorVC
                errorVC.errors = errors
            }
        }
    }
    
    private func startMoviesList(imagesHelper: ImagesHelper) {
        let child = MoviesListCoordinator(window: window, imagesHelper: imagesHelper)
        addDependency(child)
        child.start()
//        let moviesListViewController = MoviesListViewController()
//        let viewModel = MoviesListViewModel(moviesListService: MoviesListService(), imagesHelper: imagesHelper)
//        moviesListViewController.viewModel = viewModel
//        window?.rootViewController = moviesListViewController
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

fileprivate final class ErrorViewController: BaseViewController {
    var errors: [ErrorWithMessageProtocol]? {
        didSet {
            guard let errors = errors else { return }
            if !errors.isEmpty {
                view.backgroundColor = .red
                showErrorsIfNeededAndCleanup()
            }
        }
    }
    
    private func showErrorsIfNeededAndCleanup() {
        guard let errors = errors else { return }
        for error in errors {
            present(error: error)
        }
        self.errors = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showErrorsIfNeededAndCleanup()
    }
}
