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
    
    func backToEvent(_ newTask:Task)
}

class EventCoordinator: Coordinator, EventdFlow {
    
    weak var navigationController: UINavigationController?
    var controllerDic:[String: UIViewController] = [:]
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventController = EventViewController.instantiate()
        
        eventController.coordinator = self
        controllerDic = ["eventController":eventController]
        navigationController?.pushViewController(eventController, animated: false)
    }
    
    func add_item(){
        let vc = CreateTaskViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent(_ newTask: Task) {
        var ec:EventViewController!
        ec = controllerDic["eventController"] as! EventViewController
        ec.reloadTableView(newTask: newTask)
        navigationController?.popToViewController(ec, animated: false)
    }
    // MARK: - Flow Methods
    
    func changeButton(){
        
    }
}


