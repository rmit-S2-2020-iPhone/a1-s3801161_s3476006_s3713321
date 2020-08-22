//
//  TabBarCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let eventNavigationController = UINavigationController()
        eventNavigationController.tabBarItem = UITabBarItem.init(title: "Events", image: UIImage(named:"events"), tag:0)
        let eventCoordinator = EventCoordinator(navigationController: eventNavigationController)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .search, tag: 1)
        let searchViewCoordinator = SearchViewCoordinator(navigationController: searchNavigationController)
        
        
        tabBarController.viewControllers = [eventNavigationController,
                                            searchNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to:eventCoordinator)
        coordinate(to:searchViewCoordinator)
        
    }
}
