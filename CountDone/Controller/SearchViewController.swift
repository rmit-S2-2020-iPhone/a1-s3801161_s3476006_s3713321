//
//  SearchViewController.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//
//  Reference: https://www.youtube.com/watch?v=4RyhnwIRjpA&t=281s

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    var coordinator: EventdFlow?
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var tasks = [Task]() // to setup event mockup data
    var tmpEventArray = [Task]() // update event array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
        //        setUpSearchBar()
        searchBarLayout()
        tableview.isScrollEnabled = true
    }
    
    private func setUpEvents() {
        tasks = coordinator!.parentCoordinator!.tasks!
        tmpEventArray = tasks
    }
    
    // search bar
    //    private func setUpSearchBar() {
    //        //searchBar.delegate = self
    //    }
    
}


extension SearchViewController : CellDelegate {
    func customcell(cell: TaskTableViewCell) {
        //        coordinator!.currentCell =  cell
        coordinator?.add_item()
    }
}

extension SearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpEventArray.count
        //  return the number of array items in tableView
    }
    
    
    // table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.typeEmojiLabel.text = tmpEventArray[indexPath.row].typeEmoji
        cell.titleLabel.text = tmpEventArray[indexPath.row].title
        
        let calender = Calendar.current
        let datetime = calender.date(from: tmpEventArray[indexPath.row].time.startDateComponent)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MMM/yyyy"
        let date = dateFormatter.string(from: datetime!)
        //        dateFormatter.dateFormat = "HH:mm E"
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: datetime!)
        
        cell.dateLabel.text = date
        cell.timeLabel.text = time
        
        cell.delegate = self
        cell.task = tmpEventArray[indexPath.row]
        
        
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
            tmpEventArray = tasks
            tableview.reloadData()
            return
        }
        tmpEventArray = tasks.filter({ event -> Bool in
            (event.title.lowercased().contains(searchText.lowercased()) || event.date.lowercased().contains(searchText.lowercased()))
            // if the text typed in the search bar matching the event, it will show the result
        })
        tableview.reloadData()
        
    }
}

//Mark:- Table view setting
extension SearchViewController{
    private func searchBarLayout() {
        tableview.tableHeaderView = UIView()
        tableview.estimatedSectionHeaderHeight = 50
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
