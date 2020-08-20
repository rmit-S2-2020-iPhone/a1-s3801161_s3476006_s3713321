//
//  ViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class search_D {
    
}

class CountDoneViewController: UITableViewController {

    var search_display = [search_D]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO: listing data for search display
        //search_display.append(search_D(description: "purchase book"))
        //search_display.append(search_D(description: "barbecue party"))
    }

    
    //MARK:- Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItems", for: indexPath)
        let date = cell.viewWithTag(999) as! UILabel
        let time = cell.viewWithTag(1000) as! UILabel
        let emoji = cell.viewWithTag(1001) as! UILabel
        let title = cell.viewWithTag(1002) as! UILabel
        let decription = cell.viewWithTag(1003) as! UILabel
        
        date.text = "Mon"
        time.text = "09:00"
        emoji.text = "🏃‍♀️"
        title.text = "Morning Jog"
        decription.text = "5km run in 30 mins"
        
        return cell
    }
    
    //MARK:- Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if(cell.accessoryType == .none){
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    

}

