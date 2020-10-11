//
//  EventsCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//
import UIKit

protocol EventFlow: class {
    var currentCell: TaskTableViewCell?{get set}
    var parentCoordinator:TabBarCoordinator?{get set}
    func add_item()
    func edit_item(task: Task)
    func delete_item()
    func showDetails()
    func backToEvent()
    func logout()
}



class EventCoordinator: Coordinator, EventFlow {
    
    
    func tagSelection(tag: String) {
        
    }
    
    func tagSet(tag: Tag) {
        
    }
    
    
    
 
    var currentCell: TaskTableViewCell?
    
    weak var navigationController: UINavigationController?
    
    var controllerDic:[String: UIViewController] = [:]
    var parentCoordinator:TabBarCoordinator?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.tabBarItem.badgeColor = .white

    }
    
    func start() {
        let eventController = EventViewController.instantiate()

        eventController.coordinator = self
        controllerDic = ["eventController":eventController]
        navigationController?.pushViewController(eventController, animated: false)
    }
    

    
    func add_item(){
        let vc = CreateTaskTableViewController.instantiate(editMode: false)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func edit_item(task: Task) {
        let vc = CreateTaskTableViewController.instantiate(editMode: true, task: task)
        vc.coordinator = self
        vc.navigationItem.title = "Edit Task"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showDetails(){
        let vc = DetailsTableViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent() {
        var ec:EventViewController!
        ec = controllerDic["eventController"] as? EventViewController
        navigationController?.popToViewController(ec, animated: false)
        
    }

    func logout() {
        
        parentCoordinator?.logout()
        
    }
    
    func delete_item() {}
}
