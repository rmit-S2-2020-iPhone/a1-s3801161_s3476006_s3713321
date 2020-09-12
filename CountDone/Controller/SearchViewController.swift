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
    
    var coordinator: EventdFlow?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var tasks = [Task]() // to setup event mockup data
//    var tmpEventArray = [Task]() // update event array
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpEvents()
        //        setUpSearchBar()
        searchBarLayout()
//        tableview.isScrollEnabled = true
        
        reloadData()
//        self.tmpEventArray = self.tasks
    }
    func reloadData() {
        //Request
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        // Init
        let sortByDate = NSSortDescriptor(key: "taskTime.startDate", ascending: true)
//        let sortByCheck = NSSortDescriptor(key: "checked", ascending: true)
        request.sortDescriptors = [sortByDate]
        
        //Fetch
        do{
            let tasks = try CoreDataStack.shared.context.fetch(request)
            self.tasks = tasks
        } catch{}
        
        self.tableView.reloadData()
    }
//    private func setUpEvents() {
//        tasks = coordinator!.parentCoordinator!.tasks!
//        tmpEventArray = tasks
//    }
    
    // search bar
    //    private func setUpSearchBar() {
    //        //searchBar.delegate = self
    //    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        navigationItem.title = "\(tasks.count) results found"
//        self.tmpEventArray = self.tasks

    }
}


extension SearchViewController : CellDelegate {
    func customcell(cell: TaskTableViewCell) {
        //        coordinator!.currentCell =  cell
        coordinator?.add_item()
    }
}

extension SearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        //  return the number of array items in tableView
    }
    
    
    // table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.typeEmojiLabel.text = tasks[indexPath.row].typeEmoji
        cell.titleLabel.text = tasks[indexPath.row].title
        
//        let calender = Calendar.current
//        let datetime = calender.date(from: tmpEventArray[indexPath.row].taskTime.startDateComponent)
        let dateTime = tasks[indexPath.row].taskTime.startDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MMM/yyyy"
        let date = dateFormatter.string(from: dateTime as Date)
        //        dateFormatter.dateFormat = "HH:mm E"
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: dateTime as Date)
        
        cell.dateLabel.text = date
        cell.timeLabel.text = time
        
        cell.delegate = self
        cell.task = tasks[indexPath.row]
        
        
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
        guard !searchText.isEmpty else {
//            tmpEventArray = tasks
            reloadData()
//            tableView.reloadData()
            navigationItem.title = "\(tasks.count) results found"
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, d MMM yyyy"
        
        tasks = tasks.filter({ event -> Bool in
            (event.title.lowercased().contains(searchText.lowercased()) || dateFormatter.string(from: event.taskTime.startDate as Date).lowercased().contains(searchText.lowercased())
                )

            // if the text typed in the search bar matching the event, it will show the result
        })
        tableView.reloadData()
        navigationItem.title = "\(tasks.count) results found"
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
