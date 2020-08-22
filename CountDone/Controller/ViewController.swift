//
//  ViewController.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//
//  Reference: https://www.youtube.com/watch?v=4RyhnwIRjpA&t=281s

import UIKit

class ViewController: UIViewController, UITableViewDataSource, Storyboarded {

    
    var coordinator: SearchViewFlow?
    
    @IBOutlet var searchTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var eventArray = [Event]() // to setup event mockup data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func setUpEvents() {
        eventArray.append(Event(typeEmoji: "🧪", title: "lab test", date: "11/Sep/2020", time: "10:00a.m."))
        eventArray.append(Event(typeEmoji: "🛒", title: "shopping", date: "13/Sep/2020", time: "all day"))
        eventArray.append(Event(typeEmoji: "👰", title: "shaw's wedding", date: "08/Oct/2020", time: "11:00a.m."))
        eventArray.append(Event(typeEmoji: "🎉", title: "graduation party", date: "11/Nov/2020", time: "6:00p.m."))
        eventArray.append(Event(typeEmoji: "✈️", title: "to europe", date: "11/Dec/2020", time: "6:30a.m."))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
        //  return the number of array items in tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.typeEmojiLabel.text = eventArray[indexPath.row].typeEmoji
        cell.titleLabel.text = eventArray[indexPath.row].title
        cell.dateLabel.text = eventArray[indexPath.row].date
        cell.timeLabel.text = eventArray[indexPath.row].time
        
        return cell
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
