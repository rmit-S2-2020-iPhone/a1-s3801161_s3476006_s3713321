//
//  userViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/9/30.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class userViewController:UITableViewController{
    
    //load context from the coredatastack
    let context = CoreDataStack.shared.context
    var items:[UserAccount]?
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserAccount.fetchRequest())
    
    override func viewDidLoad() {
        try! context.execute(deleteRequest)
        super.viewDidLoad()
        let rest = REST_Request()
        rest.getUsers(withEmail: "duanxinhuan@163.com")
        initUsers()
    }
    
    //load data from the core data
    func fetchUsers(){
        self.items = try! context.fetch(UserAccount.fetchRequest())
        
        self.tableView.reloadData()
        
    }
    
    func initUsers(){
        let user = UserAccount(context: self.context)
        user.username = "duanxinhuan"
        user.email = "duanxinhuan@163.com"
        try! self.context.save()
        self.fetchUsers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! TaskTableViewCell
        let user = self.items![indexPath.row]
        cell.titleLabel?.text = user.username
        return cell
    }
    
}
