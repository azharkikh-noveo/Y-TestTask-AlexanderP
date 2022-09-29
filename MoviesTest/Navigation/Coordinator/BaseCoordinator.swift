//
//  BaseCoordinator.swift
//

import Foundation

class BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    
    /// Do not call super when overriding
    func start() {
        fatalError("Pure virtual function call")
    }
    
    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
