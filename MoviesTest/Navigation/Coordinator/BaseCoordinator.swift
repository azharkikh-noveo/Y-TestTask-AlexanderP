//
//  BaseCoordinator.swift
//

import Foundation

class BaseCoordinator: Coordinatable {
    
    weak var presenter: BaseNavigationController?
    var childCoordinators: [Coordinatable] = []
    var flowCompletion: CoordinatorHandler?
    var systemEventFlowCompletion: CoordinatorHandler?
    
    func start() {
        //TODO: - IMP
    }
    
    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
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
