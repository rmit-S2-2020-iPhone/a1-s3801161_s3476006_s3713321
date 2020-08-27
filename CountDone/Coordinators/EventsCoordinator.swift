//
//  EventsCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//
import UIKit

protocol EventdFlow: class {
<<<<<<< HEAD
    func add_item()
    
    func backToEvent(_ newTask:Task)
=======
   func add_item()
>>>>>>> cy
}

class EventCoordinator: Coordinator, EventdFlow {
    
    weak var navigationController: UINavigationController?
<<<<<<< HEAD
    var controllerDic:[String: UIViewController] = [:]
=======
    
>>>>>>> cy
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventController = EventViewController.instantiate()
        
        eventController.coordinator = self
<<<<<<< HEAD
        controllerDic = ["eventController":eventController]
=======
        
>>>>>>> cy
        navigationController?.pushViewController(eventController, animated: false)
    }
    
    func add_item(){
        let vc = CreateTaskViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
<<<<<<< HEAD
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


=======
    // MARK: - Flow Methods
    
}
>>>>>>> cy
