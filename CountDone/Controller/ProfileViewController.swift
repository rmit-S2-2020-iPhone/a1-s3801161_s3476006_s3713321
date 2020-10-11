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
    
    
    //    var profileVM = [ProfileViewModel]()
    var profiles = [Student]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setUpStudent()
    }
    
    private func setUpStudent() {
        profiles.append(Student(name: "Name: \nXinhuan Duan", student_no: "Student No: \ns3713321", hobby: "Hobby: Hanging out \nwith girlfriend", photo: "gouge"))
        profiles.append(Student(name: "Name: \nFanwei Wang", student_no: "Student No: \ns3801161", hobby: "Hobby: \nEat and sleep", photo: "lucas"))
        profiles.append(Student(name: "Name: \nChangyu Yu", student_no: "Student No: \ns3476006", hobby: "Hobby: Gaming", photo: "cy"))
    }
}

class Student {
    let name: String
    let student_no: String
    let hobby: String
    let photo: String
    
    init(name: String, student_no: String, hobby: String, photo: String) {
        self.name = name
        self.student_no = student_no
        self.hobby = hobby
        self.photo = photo
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
        return profiles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt profileIndexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileViewCell else {
            return UITableViewCell()
        }
        cell.username.text = profiles[profileIndexPath.row].name
        cell.email.text = profiles[profileIndexPath.row].student_no
        cell.user_description.text = profiles[profileIndexPath.row].hobby
        cell.photo.image = UIImage(named: profiles[profileIndexPath.row].photo)
        
        cell.profileIndexPath = profileIndexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt profileIndexPath: IndexPath) -> CGFloat {
        return 100
    }
}
