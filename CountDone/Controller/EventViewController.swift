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
    var coordinator: EventFlow?
    
    var selectedDate = Date()
    var dateFrom:Date?
    var dateTo:Date?
    var calendar = Calendar.current
    
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet weak var navigationbar: UINavigationItem!
    @IBOutlet weak var dateButton: UIBarButtonItem!
    
    var tasks = [Task]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateRange()        
        setCalendarLayer()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
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


//extension EventViewController:CalendarDelegate{
//    func passSelectedDate(date: Date) {
//        selectedDate = date
//        setDateRange()
//        reloadData()
//    }
//
//
//}

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
        cell.checkBoxDelegate = self
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



//extension EventViewController{
//
//
//    func getJson() {
//        guard let json_url = Bundle.main.url(forResource: "http://ipse-33-290502.appspot.com/users/duanxinhuan@163.com", withExtension: nil),
//            let data = try? Data.init(contentsOf: json_url) else {
//                fatalError("json fetch failed")
//        }
//
//        let decoder = JSONDecoder()
//        guard let task = try? decoder.decode([tasks].self, from: data) else {
//            fatalError("json decode failed")
//        }
//        reloadData()
//    }
//}

