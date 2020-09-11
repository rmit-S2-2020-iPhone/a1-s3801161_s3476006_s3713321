//
//  SearchViewCoordinator.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class SearchViewCoordinator: Coordinator, EventdFlow {

    var parentCoordinator: TabBarCoordinator?
    
    var currentCell: TaskTableViewCell?
    
    var searchViewController:SearchViewController?
    
    var controllerDic:[String: UIViewController] = [:]

    func showDetails(){
        let vc = DetailsTableViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent(_ newTask: Task) {
        var sc: SearchViewController!
        sc = controllerDic["SearchViewController"] as? SearchViewController
     
        navigationController?.popToViewController(sc, animated: false)
        
    }
    func edit_item(task: Task) {
        let vc = CreateTaskTableViewController.instantiate()
        vc.coordinator = self
        vc.editModeOn()
        vc.task = task
        vc.navigationItem.title = "Edit task"
        self.start()
        self.parentCoordinator?.eventCoordinator?.start()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        searchViewController = SearchViewController.instantiate()
        
        
        searchViewController!.coordinator = self
        
        controllerDic = ["SearchViewController":searchViewController!]
        
        navigationController?.pushViewController(searchViewController!, animated: false)
    }
    
    func add_item() {}
    func delete_item() {}
}
