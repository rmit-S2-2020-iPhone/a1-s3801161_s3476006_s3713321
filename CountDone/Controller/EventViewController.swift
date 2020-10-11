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
    
    let transition = SlideTransit()
    var topView:UIView?
    
    
    var taskViewModel = TaskViewModel()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var navigationbar: UINavigationItem!
    @IBOutlet weak var dateButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.taskViewModel.reloadData(in: .main)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setDateRange()
        setCalendarLayer()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func AddItem(_ sender: Any) {
        coordinator?.add_item()
    }
    
    
    func setTableView(){
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func setDateRange(){
        
        let format = DateFormatter()
        format.dateFormat = "d MMM"
        dateButton.title = format.string(from: self.taskViewModel.selectedDate)
        format.dateFormat = "EEEE"
        
        if self.taskViewModel.calendar.isDateInToday(self.taskViewModel.selectedDate){
            navigationbar.title = "Today"
        }else if self.taskViewModel.calendar.isDateInTomorrow(self.taskViewModel.selectedDate){
            navigationbar.title = "Tomorrow"
        }else if self.taskViewModel.calendar.isDateInYesterday(self.taskViewModel.selectedDate){
            navigationbar.title = "Yesterday"
        }else{
            navigationbar.title = format.string(from: self.taskViewModel.selectedDate)
        }
        
        
    }
    
    func setCalendarLayer() {
        addButton.layer.cornerRadius = addButton.frame.height/2
        addButton.layer.shadowOpacity = 0.25
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCalendarSegue"{
            let popup = segue.destination as! CalenderViewController
            popup.onSave = {(date) in
                self.taskViewModel.selectedDate = date
                self.setDateRange()
                self.taskViewModel.reloadData(in: .main)
                self.tableView.reloadData()
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
        self.taskViewModel.getTaskFor(index).checked = checked
        self.taskViewModel.reloadData(in: .main)
        self.tableView.reloadData()
    }
}

//MARK:- Table view data source
extension EventViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let task = taskViewModel.getTaskFor(indexPath.row)
        cell.setTaskCell(task: task, in: .main)
        configureCheckmark(for: cell, with: cell.task!)
        
        cell.delegate = self
        cell.checkBoxDelegate = self
        cell.indexPath = indexPath.row
        
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
            taskViewModel.deleteTask(at: indexPath.row)
            taskViewModel.reloadData(in: .main)
            tableView.reloadData()
//            deleteTask(indexPath: indexPath)
        }
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


extension EventViewController:UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresneting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresneting = false
        return transition
    }
}

extension EventViewController{
    @IBAction func didTapMenu(_ sender: Any) {
        guard let  menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuViewController")  as? MenuViewController else {return}
        menuVC.didTapMenuType = {menuType in
            self.transitionToNewContent(menuType)
        }
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = self
        self.present(menuVC, animated: true, completion: nil)
        
    }
    
    func transitionToNewContent(_  menuType: MenuType){
        
        
        topView?.removeFromSuperview()
        switch menuType{
        case .home:
            print()
        case .logout:
            coordinator?.logout()
        }

    }
}
