//
//  DetailsTableViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 3/9/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController,Storyboarded {

    var coordinator: EventdFlow?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.tableFooterView = UIView(frame: .zero)
        //TODO:- Hardcoding data change later
        let currentDate  = Date()
        let currentDateTimeFormatter = DateFormatter()
        currentDateTimeFormatter.dateFormat = "HH:mm E, d MMM"
        let task = Task(title: "Run", typeEmoji: "🏃", description: "Run from house to school", date: currentDate, checked: true)
        
        setDetails(from: task )
    }

    func setDetails(from task: Task){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        dateLabel.text = dateFormatter.string(from: task.date!)
        emojiLabel.text = task.typeEmoji
        
    }
    
  


}
