//
//  SearchViewController.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//
//  Reference: https://www.youtube.com/watch?v=4RyhnwIRjpA&t=281s

import UIKit
import CoreData

class SearchViewController: UIViewController, Storyboarded {
    
    var coordinator: EventFlow?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var taskViewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.text = nil
        taskViewModel.reloadData(in: .search)
        tableView.reloadData()
        navigationItem.title = "\(taskViewModel.count) results found"
    }
}

extension SearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.count
        //  return the number of array items in tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let task = taskViewModel.tasks[indexPath.row]
        cell.setTaskCell(task: task, in: .search)
        
        return cell
    }
}
extension SearchViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:TaskTableViewCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        coordinator?.currentCell = cell
        coordinator?.showDetails()
        
        
    }
}

extension SearchViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, d MMM yyyy"
        taskViewModel.reloadData(in: .search)

        if !searchText.isEmpty {
            taskViewModel.tasks = taskViewModel.tasks.filter({ event -> Bool in
                (event.title.lowercased().contains(searchText.lowercased()) || dateFormatter.string(from: event.taskTime.startDate as Date).lowercased().contains(searchText.lowercased()))
            })
        }
        tableView.reloadData()
        navigationItem.title = "\(taskViewModel.count) results found"
    }
}

//Mark:- Table view setting
extension SearchViewController{
    private func searchBarLayout() {
        tableView.tableHeaderView = UIView()
        tableView.estimatedSectionHeaderHeight = 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // table
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
        // even if scroll down. the search bar is still on top of the page
    }
    
    // table
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
