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
    var eventCoordinator:EventCoordinator?
    var searchCoordinator:SearchViewCoordinator?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var tasks:[Task]?
    func start() {
        tasks = [Task(title: "fuel up", typeEmoji: "⛽️", description: "fuel up for school",time: Time(year: 2020, month: 9, day: 2, hour: 13, min: 44), checked: false),
            Task(title: "lab test", typeEmoji: "🧪", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
           Task(title: "shopping", typeEmoji: "🛒",description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
            Task(title: "bachelor party", typeEmoji: "🎉", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
           Task(title: "shaw's wedding", typeEmoji: "👰", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
            Task(title: "graduation party", typeEmoji: "🎓", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
           Task(title: "to europe", typeEmoji: "✈️", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
            Task(title: "car maintenance", typeEmoji: "🚗", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false),
            Task(title: "vaccination", typeEmoji: "💉", description: "AA test ",time: Time(year: 2020, month: 9, day: 3, hour: 14, min: 11), checked: false)]
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let eventNavigationController = UINavigationController()
        eventNavigationController.tabBarItem = UITabBarItem.init(title: "Events", image: UIImage(named:"events"), tag:0)
        self.eventCoordinator = EventCoordinator(navigationController: eventNavigationController)
        eventCoordinator!.parentCoordinator = self
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .search, tag: 1)
        searchCoordinator = SearchViewCoordinator(navigationController: searchNavigationController)
        searchCoordinator!.parentCoordinator = self
        
        let calenderNavigationController = UINavigationController()
        calenderNavigationController.tabBarItem = UITabBarItem(
            title: "Calender", image: UIImage(named:"events"), tag:2)
        let calenderCoordinator = CalenderCoordinator(navigationController: calenderNavigationController)
        tabBarController.viewControllers = [eventNavigationController,
                                            searchNavigationController,
                                            calenderNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to:eventCoordinator!)
        coordinate(to:searchCoordinator!)
        coordinate(to:calenderCoordinator)
        
    }
}
