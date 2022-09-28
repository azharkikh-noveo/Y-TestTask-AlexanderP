//
//  Router.swift
//

import UIKit

protocol Router {
    var presenter: BaseNavigationController? { get }
    func present(controller: UIViewController, animated: Bool)
    func push(controller: UIViewController, animated: Bool, hideBottomBar: Bool)
    func popController(animated: Bool)
    func dismissController(animated: Bool)
    func popToRoot(animated: Bool)
    func setRoot(_ root: UIViewController)
    func setControllers(_ controllers: [UIViewController])
}

extension Router {
    
    func present(controller: UIViewController, animated: Bool = true) {
        self.presenter?.present(controller, animated: animated, completion: nil)
    }
    
    func push(controller: UIViewController, animated: Bool = true, hideBottomBar: Bool = true) {
        controller.hidesBottomBarWhenPushed = hideBottomBar
        self.presenter?.pushViewController(controller, animated: animated)
    }
    
    func popController(animated: Bool = true) {
        self.presenter?.popViewController(animated: animated)
    }
    
    func dismissController(animated: Bool = true) {
        self.presenter?.dismiss(animated: animated, completion: nil)
    }
    
    func popToRoot(animated: Bool = true) {
        self.presenter?.popToRootViewController(animated: animated)
    }
    
    func setRoot(_ root: UIViewController) {
        self.presenter?.viewControllers = [root]
    }
    
    func setControllers(_ controllers: [UIViewController]) {
        self.presenter?.viewControllers = controllers
    }
}
