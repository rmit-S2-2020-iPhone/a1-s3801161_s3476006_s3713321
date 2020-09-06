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
    
    var task:Task?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var editButton: UIButton!
//    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = coordinator?.currentCell!
        task = (cell?.task!)!
        self.setDetails(from: task! )
        
//        deleteButton.isEnabled = false
    }

    func setDetails(from task: Task){
        let calender = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        let dateTime = calender.date(from: task.time.startDateComponent)
        dateLabel.text = dateFormatter.string(from: dateTime!)
        emojiLabel.text = task.typeEmoji
        
    }
    
    @IBAction func editTask(_ sender: Any) {
        coordinator?.edit_item(task: task!)
    }
    
//    @IBAction func deleteTask(_ sender: Any) {
//        coordinator?.delete_item()
//    }
//

}
