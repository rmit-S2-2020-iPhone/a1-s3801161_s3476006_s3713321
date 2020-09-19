//
//  ViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import CoreData

class EventViewController: UIViewController,Storyboarded {
    var coordinator: EventdFlow?
    
    @IBOutlet var tableView: UITableView!
   
    var tasks = [Task]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func AddItem(_ sender: Any) {
        coordinator?.add_item()
    }
    
    func reloadData() {
        //Request
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        // Init
        let sortByDate = NSSortDescriptor(key: "taskTime.startDate", ascending: true)
        let sortByCheck = NSSortDescriptor(key: "checked", ascending: true)
        request.sortDescriptors = [sortByCheck,sortByDate]
        
        //Fetch
        do{
            let tasks = try CoreDataStack.shared.context.fetch(request)
            self.tasks = tasks
        } catch{}
        
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    //Reload Table view
//    func reloadTableView(newTask : Task){
//        tasks.append(newTask)
////        coordinator?.parentCoordinator?.tasks?.append(newTask)
//        tableView.reloadData()
//        self.coordinator?.parentCoordinator?.searchCoordinator?.start()
//    }
    
}

extension EventViewController: CellDelegate{
    func customcell(cell: TaskTableViewCell) {
        coordinator!.currentCell =  cell
        coordinator?.showDetails()
    }
}

extension EventViewController:CheckBoxDelegate{
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        reloadData()
    }
}


//MARK:- Table view data source
extension EventViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        let dateTime = tasks[indexPath.row].taskTime.startDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: dateTime as Date)
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: dateTime as Date)
        
        cell.typeEmojiLabel.text = tasks[indexPath.row].typeEmoji
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.descriptionLabel.text = tasks[indexPath.row].taskDescrip
        cell.dateLabel.text = date
        cell.timeLabel.text = time
        
        configureCheckmark(for: cell, with: tasks[indexPath.row])
        
        cell.delegate = self
        cell.changeButtonDelegate = self
        cell.indexPath = indexPath.row
        cell.task = tasks[indexPath.row]
        return cell
    }
}


//MARK:- Table view editing
extension EventViewController{
    //set cell not be selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: Delete task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            deleteTask(indexPath: indexPath)
        }
    }
    
    func deleteTask(indexPath: IndexPath){
        let task = tasks[indexPath.row]
        tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        CoreDataStack.shared.delete(task)
//        self.coordinator?.parentCoordinator?.tasks?.remove(at: indexPath.row)
//        self.coordinator?.parentCoordinator?.searchCoordinator?.start()
    }
    
    //MARK: Confirgure the checkmark
    func configureCheckmark(for cell: TaskTableViewCell,with item: Task) {
        
//        let checkAttribute: NSAttributedString = NSAttributedString()
//        let uncheckAttribute: NSAttributedString = NSAttributedString()
        
        
        if item.checked{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            
        }else{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
        }

    }
}
