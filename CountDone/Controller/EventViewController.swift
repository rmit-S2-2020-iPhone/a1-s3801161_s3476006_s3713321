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
   
    // MARK: -sidebar delegate
    // reference: https://www.youtube.com/watch?v=dB-vB9uDRCI
    
    

    
    var coordinator: EventFlow?
//    var mcoordinator: MenuFlow?
//    var sideBarDelegate: SideBarDelegate?
    
    var selectedDate = Date()
    var dateFrom:Date?
    var dateTo:Date?
    var calendar = Calendar.current
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet weak var navigationbar: UINavigationItem!
    @IBOutlet weak var dateButton: UIBarButtonItem!
    
    var taskViewModels = [TaskViewModel]()
    var tasks = [Task]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        reloadData()
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        configureSideBar()
        setDateRange()
        setCalendarLayer()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    var sideBarDelegate: SideBarDelegate?
    
    // MARK: -sidebar
    // reference: https://www.youtube.com/watch?v=dB-vB9uDRCI
//    @objc func handleMenu() {
//        // to link the two controllers
//        print("menu here")
//        sideBarDelegate?.handleMenu()
//    }
//
//    func configureSideBar() {
//        navigationController?.navigationBar.barTintColor = .lightGray
//        navigationController?.navigationBar.barStyle = .blackOpaque
//
//        //        navigationItem.title = "Menu"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
//    }
    
    
    @IBAction func AddItem(_ sender: Any) {
        coordinator?.add_item()
    }
    
    
    func setDateRange(){
        calendar.timeZone = NSTimeZone.local
        let format = DateFormatter()
        format.dateFormat = "d MMM"
        dateButton.title = format.string(from: selectedDate)
        format.dateFormat = "EEEE"
        
        if calendar.isDateInToday(selectedDate){
            navigationbar.title = "Today"
        }else if calendar.isDateInTomorrow(selectedDate){
            navigationbar.title = "Tomorrow"
        }else if calendar.isDateInYesterday(selectedDate){
            navigationbar.title = "Yesterday"
        }else{
            navigationbar.title = format.string(from: selectedDate)
        }
        
        dateFrom = calendar.startOfDay(for: selectedDate)
        dateTo = calendar.date(byAdding: .day, value: 1,to: dateFrom!)
    }
    
    func setCalendarLayer() {
        addButton.layer.cornerRadius = addButton.frame.height/2
        addButton.layer.shadowOpacity = 0.25
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func reloadData() {
        //Request
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        

        //set sort
        let sortByDate = NSSortDescriptor(key: "taskTime.startDate", ascending: true)
        let sortByCheck = NSSortDescriptor(key: "checked", ascending: true)
        request.sortDescriptors = [sortByCheck,sortByDate]
        //set filter
        let fromPredicate = NSPredicate(format: "taskTime.startDate >= %@", dateFrom! as NSDate)
        let toPredicate = NSPredicate(format: "taskTime.startDate < %@", dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
  
        //Fetch
        do{
            let tasks = try CoreDataStack.shared.context.fetch(request)
            self.taskViewModels = tasks.map({
                return TaskViewModel(task: $0)
            })
            self.tasks = tasks
        } catch{}
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCalendarSegue"{
            let popup = segue.destination as! CalenderViewController
            popup.onSave = {(date) in
                self.selectedDate = date
                self.setDateRange()
                self.reloadData()
            }
        }
    }
    
    func sidebar(for segue2: UIStoryboardSegue, sender: Any?) {
        if segue2.identifier == "toSideBarSegue"{
            _ = segue2.destination as! MenuController
            sideBarDelegate?.handleMenu()
        }
    }
    
}

extension EventViewController: CellDelegate{
    func customcell(cell: TaskTableViewCell) {
        coordinator!.currentCell =  cell
        coordinator?.showDetails()
    }
}

extension EventViewController:CheckBoxDelegate{
    func changeButton(checked: Bool, index: Int) {
        taskViewModels[index].checked = checked
        reloadData()
    }
}


//MARK:- Table view data source
extension EventViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        //get date & time from taskTime
        let dateTime = taskViewModels[indexPath.row].taskTime.startDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: dateTime as Date)
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: dateTime as Date)
        
        //set task detail on cell
        cell.typeEmojiLabel.text = taskViewModels[indexPath.row].typeEmoji
        cell.titleLabel.text = taskViewModels[indexPath.row].title
        cell.descriptionLabel.text = taskViewModels[indexPath.row].taskDescrip
        cell.dateLabel.text = date
        cell.timeLabel.text = time
        
        configureCheckmark(for: cell, with: taskViewModels[indexPath.row])
        
        cell.delegate = self
        cell.checkBoxDelegate = self
        cell.indexPath = indexPath.row
        cell.task = taskViewModels[indexPath.row]
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
        taskViewModels.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        CoreDataStack.shared.delete(task)
    }
    
    //MARK: Confirgure the checkmark
    func configureCheckmark(for cell: TaskTableViewCell,with item: TaskViewModel) {
        
        //        let checkAttribute: NSAttributedString = NSAttributedString()
        //        let uncheckAttribute: NSAttributedString = NSAttributedString()
        
        if item.checked{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            
        }else{
            cell.checkBox.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
        }
        
    }
}





