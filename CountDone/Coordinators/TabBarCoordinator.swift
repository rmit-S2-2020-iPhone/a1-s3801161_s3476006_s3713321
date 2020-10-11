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
//
//        let calenderNavigationController = UINavigationController()
//        calenderNavigationController.tabBarItem = UITabBarItem(
//            title: "Calender", image: UIImage(named:"events"), tag:2)
//        let calenderCoordinator = CalenderCoordinator(navigationController: calenderNavigationController)
        tabBarController.viewControllers = [eventNavigationController,
                                            searchNavigationController]
//            ,calenderNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to:eventCoordinator!)
        coordinate(to:searchCoordinator!)
//        coordinate(to:calenderCoordinator)
        
    }
    
    
    func logout(){

        // get a reference to the app delegate
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        // call didFinishLaunchWithOptions ... why?
        let _ = appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
//        let startCoordinator = StartCoordinator(navigationController: self.navigationController)
//        coordinate(to: startCoordinator)
    }
    
    
}
