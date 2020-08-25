//
//  ViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
class EventViewController: UITableViewController,ChangeButton,Storyboarded {
   
     var tasks:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 50.0
        
        //TODO:- Hardcoding data change later
        let currentDate  = Date()
        let currentDateTimeFormatter = DateFormatter()
        currentDateTimeFormatter.dateFormat = "HH:mm E, d MMM"
        
        tasks.append(Task(title: "Run", typeEmoji: "🏃", description: "Run from house to school", date: currentDate, checked: true))
    }
    
     var coordinator: EventdFlow?

    
    //MARK:- Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
//        cell.titleLabel.text = tasks[indexPath.row].title
//        cell.subtitleLabel.text = tasks[indexPath.row].description
//        cell.typeEmoji.text = tasks[indexPath.row].typeEmoji
//        cell.dateLabel.text = tasks[indexPath.row].date
//        cell.timeLabel.text = tasks[indexPath.row].title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: tasks[indexPath.row].date!)
        dateFormatter.dateFormat = "HH:mm E"
        let time = dateFormatter.string(from: tasks[indexPath.row].date!)
        
        cell.typeEmojiLabel.text = tasks[indexPath.row].typeEmoji
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.dateLabel.text = date
        cell.timeLabel.text = time
        
        
//        configureCheckmark(for: cell, with: tasks[indexPath.row])
        

        cell.delegate = self
//        cell.indexPath = indexPath.row
//        cell.tasks = tasks
        
        
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
    func configureCheckmark(for cell: SearchTableViewCell,with item: Task) {
//        if item.checked{
//            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .normal)
//
//        }else{
//            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
//        }
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
    
    @IBAction func AddItem(_ sender: Any) {
        coordinator?.add_item()
    }
    
    func reloadTableView(newTask : Task){
        tasks.append(newTask)
        tableView.reloadData()
    }
    
   
    
}

extension EventViewController: CellDelegate{
    func customcell(cell: SearchTableViewCell) {
        coordinator?.add_item()
    }
    
    
    
    
}
