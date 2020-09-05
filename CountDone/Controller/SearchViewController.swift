//
//  SearchViewController.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//
//  Reference: https://www.youtube.com/watch?v=4RyhnwIRjpA&t=281s

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, Storyboarded {
    
    
    @IBOutlet var searchTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var eventArray = [Task]() // to setup event mockup data
    var tmpEventArray = [Task]() // update event array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
        setUpSearchBar()
        searchBarLayout()
        searchTable.isScrollEnabled = true
    }
    
   
    
    
    private func setUpEvents() {
        eventArray =  (self.coordinator?.parentCoordinator?.tasks!)!
        
        tmpEventArray = eventArray
    }
    
    // search bar
    private func setUpSearchBar() {
        //searchBar.delegate = self
    }
    
    private func searchBarLayout() {
        searchTable.tableHeaderView = UIView()
        searchTable.estimatedSectionHeaderHeight = 50
    }
    
   
    // action
    //@IBAction func addThisTask(_ sender: Any) {
    //    coordinator?.add_this_task()
    //}
    //
    var coordinator: EventdFlow?
    
}



extension SearchViewController : CellDelegate {
    // table
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
        
        
        return cell
    }
    
    // table
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
    
    // search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            tmpEventArray = eventArray
            searchTable.reloadData()
            return
        }
        tmpEventArray = eventArray.filter({ event -> Bool in
            (event.title.lowercased().contains(searchText.lowercased()) || event.date.lowercased().contains(searchText.lowercased()))
            // if the text typed in the search bar matching the event, it will show the result
        })
        searchTable.reloadData()
        
    }
    
    
    func customcell(cell: TaskTableViewCell) {
        coordinator?.add_item()
    }
    
    func detailcell(cell: TaskTableViewCell) {
        coordinator?.showDetails()
    }

}

extension SearchViewController: CellDetail{
    // respond to the click on the certain cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:TaskTableViewCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        cell.indexPath = indexPath.row
        coordinator?.currentCell = cell
        cell.tasks = self.tmpEventArray
        coordinator?.showDetails()
        
        
    }
}

