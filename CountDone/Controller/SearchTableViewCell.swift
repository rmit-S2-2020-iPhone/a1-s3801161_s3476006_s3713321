//
//  SearchTableViewCell.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//
//  reference for uibutton function: https://blog.csdn.net/sbt0198/article/details/53727709
//  reference for add uibutton: https://www.youtube.com/watch?v=fzjtvq-jC4E


import UIKit

protocol CreateThisTask {
    func addThisTask(index: Int)
}

class SearchTableViewCell: UITableViewCell {


    @IBOutlet weak var typeEmojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //@IBOutlet weak var addThisTask: UIButton!
    
    //var eventID: Int!
    //var delegate: SearchTableViewCellDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var addBtn: CreateThisTask?
    var index: IndexPath?
    
    
    @IBAction func addThisLabel(_ sender: Any) {
        addBtn?.addThisTask(index: (index?.row)!)
    }
    
    
}

