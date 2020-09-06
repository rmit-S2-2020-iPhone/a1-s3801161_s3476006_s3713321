//
//  EventsCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//
import UIKit

protocol EventdFlow: class {
    var currentCell: TaskTableViewCell?{get set}
    var parentCoordinator:TabBarCoordinator?{get set}
    func add_item()
    func edit_item(task: Task)
    func delete_item()
    func showDetails()
    func backToEvent(_ newTask:Task)
}

class EventCoordinator: Coordinator, EventdFlow {

    var currentCell: TaskTableViewCell?
    
    weak var navigationController: UINavigationController?
    
    var controllerDic:[String: UIViewController] = [:]
    var parentCoordinator:TabBarCoordinator?
    
    
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
        let vc = CreateTaskTableViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func edit_item(task: Task) {
        let vc = CreateTaskTableViewController.instantiate()
        vc.coordinator = self
        vc.task = task
        vc.editModeOn()
        vc.navigationItem.title = "Edit task"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func delete_item() {
//        var ec:EventViewController!
//        ec = controllerDic["eventController"] as? EventViewController
//        
//    
//        let cell = ec.coordinator?.currentCell!
//        let indexPath = IndexPath(row: (cell?.indexPath)!, section: 0)
//        
//        ec.deleteTask(indexPath:indexPath)
//       
//        navigationController?.popToViewController(ec, animated: false)
    }
    
    func showDetails(){
        let vc = DetailsTableViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent(_ newTask: Task) {
        var ec:EventViewController!
        ec = controllerDic["eventController"] as? EventViewController
        
        ec.reloadTableView(newTask: newTask)
        
        
        navigationController?.popToViewController(ec, animated: false)
        
    }

}
