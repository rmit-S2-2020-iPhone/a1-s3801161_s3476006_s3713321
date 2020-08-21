//
//  StartCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

protocol StartFlow: class {
    func coordinateToTabBar()
}

class StartCoordinator: Coordinator, StartFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = StartViewController()
        startViewController.coordinator = self
        navigationController.pushViewController(startViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
}
