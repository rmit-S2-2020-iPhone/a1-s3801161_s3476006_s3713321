//
//  EventsCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//
import UIKit

protocol EventdFlow: class {
   func add_item()
    func backToEvent()
}

class EventCoordinator: Coordinator, EventdFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventController = EventViewController.instantiate()
        
        eventController.coordinator = self
        
        navigationController?.pushViewController(eventController, animated: false)
    }
    
    func add_item(){
        let vc = CreateTaskViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent(){
        let vc = EventViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: - Flow Methods
    
}
