//
//  TagCell.swift
//  CountDone
//
//  Created by Fanwei Wang on 10/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {

    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTag(tag: Tag){
        emoji.text = tag.tagEmoji
        name.text = tag.tagName
    }

}
