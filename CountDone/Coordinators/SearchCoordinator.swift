//
//  SearchViewCoordinator.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class SearchViewCoordinator: Coordinator, EventFlow {
   
    
    
    
    
    
    var parentCoordinator: TabBarCoordinator?
    
    var currentCell: TaskTableViewCell?
    
    var searchViewController:SearchViewController?
    
    var controllerDic:[String: UIViewController] = [:]
    
    func showDetails(){
        // show details of a item
        let vc = DetailsTableViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent() {
        // go back to event page
        var sc: SearchViewController!
        sc = controllerDic["SearchViewController"] as? SearchViewController
        sc.tableView.reloadData()
        
        navigationController?.popToViewController(sc, animated: false)
        
    }
    
    func edit_item(task: Task) {
        // edit an item
        let vc = CreateTaskTableViewController.instantiate(editMode: true, task: task)
        vc.coordinator = self
        vc.navigationItem.title = "Edit Task"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // start
        searchViewController = SearchViewController.instantiate()
        
        searchViewController!.coordinator = self
        
        controllerDic = ["SearchViewController":searchViewController!]
        
        navigationController?.pushViewController(searchViewController!, animated: false)
    }
    
    func add_item() {}
    func delete_item() {}
    func logout() {}
}
