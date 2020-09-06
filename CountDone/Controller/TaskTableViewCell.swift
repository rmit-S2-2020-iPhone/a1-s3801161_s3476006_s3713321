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

protocol CellDelegate: class {
    func customcell(cell:TaskTableViewCell)
}

protocol CheckBoxDelegate{
    func changeButton(checked: Bool, index: Int)
}

protocol CellDetail{
    func detailcell(cell:TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var typeEmojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var delegate : CellDelegate!
    var changeButtonDelegate:CheckBoxDelegate?
    var indexPath: Int?
    var task:Task?
    var detailcell: CellDetail?

    
    
    
    override func awakeFromNib() { 
        super.awakeFromNib()

        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func cellButtonAction(_ sender: Any) {
        delegate?.customcell(cell: self)
    }
    

    
    @IBAction func checkBoxAction(_ sender: Any) {
        if task!.checked{
            changeButtonDelegate?.changeButton(checked: false, index: indexPath!)
        }else{
            changeButtonDelegate?.changeButton(checked: true, index: indexPath!)
        }
        
    }

    
}


