//
//  CreateTaskTableViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 4/9/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import CoreData
//class CellClass: UITableViewCell{
//
//}

class CreateTaskTableViewController: UITableViewController,Storyboarded {
    var coordinator: EventFlow?
    
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var TagTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var task: Task?
    
    var editMode = false
    
    private var datePicker : UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneBarButton.isEnabled = false
        //Disable Done button if titletextfield is empty
        titleTextField.addTarget(self, action: #selector(textFileIsNotEmpty), for:.editingChanged)
        
        setDatePicker()
        
        if editMode == true{
            doneBarButton.isEnabled = true
            setEditDetail()
        }
        
    }
    
    
    @objc func textFileIsNotEmpty(textField: UITextField){
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        guard let title = titleTextField.text, !title.isEmpty
            else{
                self.doneBarButton.isEnabled = false
                return
        }
        doneBarButton.isEnabled=true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    fileprivate func setDatePicker() {
        dateTimeTextField.tintColor = UIColor .clear
        
        //default dateTimeTextField as current time
        let currentDateTime = Date()
        let currentDateTimeFormatter = DateFormatter()
        currentDateTimeFormatter.dateFormat = "HH:mm E, d MMM"
        
        dateTimeTextField.text = currentDateTimeFormatter.string(from: currentDateTime)
        
        datePicker = UIDatePicker()
        datePicker?.addTarget(self, action: #selector(CreateTaskTableViewController.dateChange(datePicker:)), for: .valueChanged)
        dateTimeTextField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateTaskTableViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTimeTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func done() {
        let title = titleTextField.text!
        let typeEmoji = TagTextField.text!
        let taskDescrip = descriptionTextField.text!
        let time = Time(context: CoreDataStack.shared.context)
        time.startDate = datePicker.date as NSDate
        
        if editMode{
            task?.title = title
            task?.taskDescrip = taskDescrip
            task?.typeEmoji = typeEmoji
            task?.taskTime = time
        }else{
            let task = Task(context: CoreDataStack.shared.context)
            task.title = title
            task.typeEmoji = typeEmoji
            task.taskDescrip = taskDescrip
            task.taskTime = time
            task.checked = false   
            
        }
        CoreDataStack.shared.save()
        coordinator?.backToEvent()
    }
    
    func editModeOn(){
        editMode = true
    }
    
    func setEditDetail(){
        let cell = coordinator?.currentCell!
        let task = cell?.task!
        
        //        let calender = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        titleTextField.text = task?.title
        descriptionTextField.text = task?.taskDescrip
        //        let dateTime = calender.date(from: task!.time.startDateComponent)
        let dateTime = task!.taskTime.startDate
        dateTimeTextField.text = dateFormatter.string(from: dateTime as Date)
        TagTextField.text = task?.typeEmoji
    }
}



