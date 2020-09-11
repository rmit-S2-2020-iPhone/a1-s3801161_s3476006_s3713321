//
//  ViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
class EventViewController: UITableViewController,Storyboarded {
    var coordinator: EventdFlow?
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = coordinator!.parentCoordinator!.tasks!
    }
    
    @IBAction func AddItem(_ sender: Any) {
        coordinator?.add_item()
    }
    
    //Reload Table view
    func reloadTableView(newTask : Task){
        tasks.append(newTask)
        coordinator?.parentCoordinator?.tasks?.append(newTask)
        tableView.reloadData()
        self.coordinator?.parentCoordinator?.searchCoordinator?.start()
    }
    
}

extension EventViewController: CellDelegate{
    func customcell(cell: TaskTableViewCell) {
        //        coordinator?.add_item()
        coordinator!.currentCell =  cell
        coordinator?.showDetails()
    }
}

extension EventViewController:CheckBoxDelegate{
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        tableView.reloadData()
    }
}


 //MARK:- Table view data source
extension EventViewController{
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let calender = Calendar.current
        let datetime = calender.date(from: tasks[indexPath.row].time.startDateComponent)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: datetime!)
        //        dateFormatter.dateFormat = "HH:mm E"
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: datetime!)
        
        cell.typeEmojiLabel.text = tasks[indexPath.row].typeEmoji
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.descriptionLabel.text = tasks[indexPath.row].description
        cell.dateLabel.text = date
        cell.timeLabel.text = time
        
        configureCheckmark(for: cell, with: tasks[indexPath.row])
        
        cell.delegate = self
        cell.changeButtonDelegate = self
        cell.indexPath = indexPath.row
        //        cell.tasks = tasks
        cell.task = tasks[indexPath.row]
        return cell
    }
}


//MARK:- Table view editing
extension EventViewController{
    //set cell not be selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: Delete task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            deleteTask(indexPath: indexPath)
        }
    }
    
    func deleteTask(indexPath: IndexPath){
        tasks.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        self.coordinator?.parentCoordinator?.tasks?.remove(at: indexPath.row)
        self.coordinator?.parentCoordinator?.searchCoordinator?.start()
    }
    
    //MARK: Confirgure the checkmark
    func configureCheckmark(for cell: TaskTableViewCell,with item: Task) {
        if item.checked{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            
        }else{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
        }
    }
}
