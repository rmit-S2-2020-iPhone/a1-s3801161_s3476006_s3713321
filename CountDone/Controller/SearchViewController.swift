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
    
    var eventArray = [Event]() // to setup event mockup data
    var tmpEventArray = [Event]() // update event array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
        setUpSearchBar()
        searchBarLayout()
        searchTable.isScrollEnabled = true
    }
    
   
    
    
    private func setUpEvents() {
        eventArray.append(Event(typeEmoji: "⛽️", title: "fuel up", date: "02/Sep/2020", time: "all day"))
        eventArray.append(Event(typeEmoji: "🧪", title: "lab test", date: "11/Sep/2020", time: "10:00a.m."))
        eventArray.append(Event(typeEmoji: "🛒", title: "shopping", date: "13/Sep/2020", time: "all day"))
        eventArray.append(Event(typeEmoji: "🎉", title: "bachelor party", date: "05/Oct/2020", time: "5:00p.m."))
        eventArray.append(Event(typeEmoji: "👰", title: "shaw's wedding", date: "08/Oct/2020", time: "11:00a.m."))
        eventArray.append(Event(typeEmoji: "🎓", title: "graduation party", date: "11/Nov/2020", time: "6:00p.m."))
        eventArray.append(Event(typeEmoji: "✈️", title: "to europe", date: "11/Dec/2020", time: "6:30a.m."))
        eventArray.append(Event(typeEmoji: "🚗", title: "car maintenance", date: "18/Dec/2020", time: "all day"))
        eventArray.append(Event(typeEmoji: "💉", title: "vaccination", date: "28/Feb/2021", time: "1:00p.m."))
        
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
        cell.dateLabel.text = tmpEventArray[indexPath.row].date
        cell.timeLabel.text = tmpEventArray[indexPath.row].time
        
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
        //let cell = tableView.cellForRow(at: indexPath)
        coordinator?.showDetails()
    }
}



class Event {
    let typeEmoji: String
    let title: String
    let date: String
    let time: String
    //let addThisTask: UIButton
    
    init(typeEmoji: String, title: String, date: String, time: String) {
        self.typeEmoji = typeEmoji
        self.title = title
        self.date = date
        self.time = time
        //self.addThisTask = addThisTask
    }
}

