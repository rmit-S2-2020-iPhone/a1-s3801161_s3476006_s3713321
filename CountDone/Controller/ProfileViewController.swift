//
//  ProfileViewController.swift
//  CountDone
//
//  Created by Changyu on 4/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, Storyboarded {
    var coordinator: ProfileFlow?
    
    @IBOutlet var tableView: UITableView!
    
//    let rest = REST_Request()
    
    
    var profileVM = [ProfileViewModel]()
    var profiles = [UserAccount]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

//extension ProfileViewController:ProfileCellDelegate{
//    func profileCustomCell(cell: ProfileViewCell) {
//        coordinator!.profileCurrentCell = cell
//    }
//
//}

extension ProfileViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rest.getAccounts().count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt profileIndexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileViewCell else {
            return UITableViewCell()
        }
        
        
//        let profiles = rest.getAccounts()
        
        let url = NSURL(string: "https://www.nationalgeographic.com/content/dam/animals/thumbs/rights-exempt/mammals/d/domestic-dog_thumb.ngsversion.1546554600360.adapt.1900.1.jpg")
        let data = NSData(contentsOf: url! as URL)
        let image = UIImage(data: data! as Data)
//        let imageView = UIImageView(image: image)
        let un = "username: gouge"
        let uemail = "email: gouge@example.org"
        let user_D = "description: gouge is very smart and handsome"
        
        cell.photo.image = image
////        cell.photo.image = profiles[profileIndexPath.row].photo
//        cell.username.text = profileVM[profileIndexPath.row].username
//        cell.email.text = profileVM[profileIndexPath.row].email
//        cell.user_description.text = profileVM[profileIndexPath.row].user_description
//

        cell.username.text = un
        cell.email.text = uemail
        cell.user_description.text = user_D

//        cell.profileDelegate = self
        cell.profileIndexPath = profileIndexPath.row
//        cell.profile = profileVM[profileIndexPath.row]
        
        return cell
        
    }
}

//extension ProfileViewController:UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt profileIndexPath: IndexPath) {
//        let cell: ProfileViewCell = tableView.cellForRow(at: profileIndexPath) as! ProfileViewCell
//        coordinator?.profileCurrentCell = cell
//    }
//}



