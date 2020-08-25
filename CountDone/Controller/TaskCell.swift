//
//  TaskCell.swift
//  CountDone
//
//  Created by Fanwei Wang on 8/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

protocol ChangeButton{
    func changeButton(checked: Bool, index: Int)
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var typeEmoji: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var date: Date?
    var delegate:ChangeButton?
    var indexPath: Int?
    var tasks:[Task]?

    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexPath!].checked{
            delegate?.changeButton(checked: false, index: indexPath!)
        }else{
            delegate?.changeButton(checked: true, index: indexPath!)
        }
        
    }
    
   
    
    
}
