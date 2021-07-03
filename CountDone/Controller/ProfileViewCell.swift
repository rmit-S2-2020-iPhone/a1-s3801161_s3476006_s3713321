//
//  ProfileViewCell.swift
//  CountDone
//
//  Created by Changyu on 4/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate: class {
    func profileCustomCell(cell: ProfileViewCell)
}

protocol ProfileCellDetail {
    func profileDetailCell(cell: ProfileViewCell)
}

class ProfileViewCell: UITableViewCell {
    
    //cell for profile
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var user_description: UILabel!
    
    weak var profileDelegate: ProfileCellDelegate!
    var profileIndexPath: Int?
    var profileVM: ProfileViewModel?
    var profileDetail: ProfileCellDetail?
}



