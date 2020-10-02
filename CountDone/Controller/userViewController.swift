//
//  userViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/9/30.
//  Copyright © 2020 G33. All rights reserved.
//
//woaizhongguo qinaidemuqin
import Foundation
import UIKit
import CoreData
import Dispatch

class userViewController:UITableViewController{
    
    //load context from the coredatastack
    let context = CoreDataStack.shared.context
    var items:[UserAccount]?
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserAccount.fetchRequest())
    let queue = DispatchQueue(label: "com.example.queue")
    let alert = UIAlertController(title: "Alert?", message: "loadding...", preferredStyle: .alert)
    
    func now(_ closure: () -> Void) {
        closure()
    }
    
    func later(_ closure: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + 2) {
            closure()
        }
    }
    
    override func viewDidLoad() {
        
    
        
//        self.items = rest.getAccounts()
        
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now()+0.5
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            self.alert.dismiss(animated: true, completion: nil)
            try! self.context.execute(self.deleteRequest)
            let rest = REST_Request()
            rest.getUsers(withEmail: "duanxinhuan@163.com")
        }
        
       
        super.viewDidLoad()
        self.fetchUsers()
        
        
    }
    

    
    //load data from the core data
    func fetchUsers(){
        print("fectching....")
        self.items = try! context.fetch(UserAccount.fetchRequest())
        print("reloading.....")
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
