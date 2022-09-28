//
//  Coordinatable.swift
//

import UIKit

protocol Coordinatable: AnyObject, Router {
    typealias CoordinatorHandler = (Coordinatable) -> Void
    var flowCompletion: CoordinatorHandler? { get set }
    func start()
}
