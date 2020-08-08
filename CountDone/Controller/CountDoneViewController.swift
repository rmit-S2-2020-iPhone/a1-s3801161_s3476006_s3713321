//
//  ViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class CountDoneViewController: UITableViewController,ChangeButton {
   

    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:- Hardcoding data change later
        tasks.append(Task(title: "Run", typeEmoji: "🏃", description: "Run from house to school", date: "Tuesday", time: "07:00", checked: false))
        
        //Large size navigation title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
    }

    
    //MARK:- Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
    
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.subtitleLabel.text = tasks[indexPath.row].description
        cell.typeEmoji.text = tasks[indexPath.row].typeEmoji
        cell.dateLabel.text = tasks[indexPath.row].date
        cell.timeLabel.text = tasks[indexPath.row].title
        
        configureCheckmark(for: cell, with: tasks[indexPath.row])
        

        cell.delegate = self
        cell.indexPath = indexPath.row
        cell.tasks = tasks
        
        
        return cell
    }
//
    //MARK:- Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            let item = tasks[indexPath.row]
//            item.toggleCheck()
//
//            configureCheckmark(for:cell as! TaskCell,with: item)
//        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Confirgure the checkmark
    func configureCheckmark(for cell: TaskCell,with item: Task) {
        if item.checked{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .normal)
            
        }else{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }

    //MARK:- Delete task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        tableView.reloadData()
    }
    
  
}

