//
//  TabBarCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var eventCoordinator:EventCoordinator?
    var searchCoordinator:SearchViewCoordinator?
    var profileCoordinator:ProfileCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let eventNavigationController = UINavigationController()
        eventNavigationController.tabBarItem = UITabBarItem.init(title: "Events", image: #imageLiteral(resourceName: "event"), tag:0)
        self.eventCoordinator = EventCoordinator(navigationController: eventNavigationController)
        eventCoordinator!.parentCoordinator = self
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem.init(title: "Search", image: #imageLiteral(resourceName: "search"), tag:1)
        searchCoordinator = SearchViewCoordinator(navigationController: searchNavigationController)
        searchCoordinator!.parentCoordinator = self
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem.init(title: "Profile", image: #imageLiteral(resourceName: "profile"), tag:2)
        profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator!.parentCoordinator = self
        
        tabBarController.viewControllers = [eventNavigationController,
                                            searchNavigationController,profileNavigationController]
        
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to:eventCoordinator!)
        coordinate(to:searchCoordinator!)
        coordinate(to:profileCoordinator!)
        
    }
    
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: "userId")
        EventManager.manager.emptyEvents()
        
        // get a reference to the app delegate
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        // call didFinishLaunchWithOptions
        let _ = appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

    }
    
    
}
