//
//  ViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class CountDoneViewController: UITableViewController {

    var items = [ToDolistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:- Hardcoding data change later
        items.append(ToDolistItem(title: "Run", typeEmoji: "🏃", description: "Run from house to school", date: "Tuesday", time: "07:00", checked: false))
        
        
        
        
        
    }

    
    //MARK:- Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItems", for: indexPath)
        let item = items[indexPath.row]
        
        let date = cell.viewWithTag(999) as! UILabel
        let time = cell.viewWithTag(1000) as! UILabel
        let emoji = cell.viewWithTag(1001) as! UILabel
        let title = cell.viewWithTag(1002) as! UILabel
        let decription = cell.viewWithTag(1003) as! UILabel
        
        date.text = item.date
        time.text = item.time
        emoji.text = item.typeEmoji
        title.text = item.title
        decription.text  = item.description
        
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    //MARK:- Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = items[indexPath.row]
            item.toggleCheck()
            
            configureCheckmark(for:cell,with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Confirgure the checkmark
    func configureCheckmark(for cell: UITableViewCell,with item: ToDolistItem) {
        if item.checked{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
    }

    //MARK:- Delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
}

