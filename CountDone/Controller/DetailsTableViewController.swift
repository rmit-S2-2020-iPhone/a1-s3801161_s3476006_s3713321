//
//  DetailsTableViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 3/9/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController,Storyboarded {

    var coordinator: EventFlow?
    
    var task:Task?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = coordinator?.currentCell!
        self.task = (cell?.task!)!
        
        self.setDetails(from: task! )
    }

    func setDetails(from task: Task){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        titleLabel.text = task.title
        descriptionLabel.text = task.taskDescrip
        let dateTime = task.taskTime.startDate
        dateLabel.text = dateFormatter.string(from: dateTime as Date)
        emojiLabel.text = task.typeEmoji
        
    }
    
    @IBAction func editTask(_ sender: Any) {
        coordinator?.edit_item(task: task!)
    }
    
}
