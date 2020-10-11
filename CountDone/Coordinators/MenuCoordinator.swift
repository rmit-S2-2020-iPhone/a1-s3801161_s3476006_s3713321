//
//  MenuCoordinator.swift
//  CountDone
//
//  Created by Changyu on 11/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit

protocol MenuFlow: class {

}

class MenuCoordinator: Coordinator, MenuFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let menuController = MenuController.instantiate()
        menuController.coordinator = self
        navigationController?.pushViewController(menuController, animated: false)
    }
    
}

