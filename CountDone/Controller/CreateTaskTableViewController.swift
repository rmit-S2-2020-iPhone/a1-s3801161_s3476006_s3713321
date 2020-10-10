//
//  CreateTaskTableViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 4/9/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import CoreData

class CreateTaskTableViewController: UITableViewController,Storyboarded {
    var coordinator: EventFlow?
    var viewModel: CreateTaskViewModel?
    //deletable
    let tagList = TagList()
    var task: Task?
    var editMode = false
    private var datePicker : UIDatePicker!
    //deletable
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var TagLabel: UILabel!
    @IBOutlet weak var tagName: UILabel!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    static func instantiate(editMode: Bool) -> CreateTaskTableViewController{
        
        let vc = CreateTaskTableViewController.instantiate()
        vc.viewModel = CreateTaskViewModel(editMode: editMode)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneBarButton.isEnabled = false
        //Disable Done button if titletextfield is empty
        titleTextField.addTarget(self, action: #selector(textFileIsNotEmpty), for:.editingChanged)
        
        setDatePicker(editMode: editMode)
        
        if editMode == true{
            doneBarButton.isEnabled = true
            setEditDetail()
        }
        
    }
    
    
    
    //Force all task has a title at least
    @objc func textFileIsNotEmpty(textField: UITextField){
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        guard let title = titleTextField.text, !title.isEmpty
            else{
                self.doneBarButton.isEnabled = false
                return
        }
        doneBarButton.isEnabled=true
    }
    
    fileprivate func setDatePicker(editMode: Bool) {
        dateTimeTextField.tintColor = UIColor .clear
        dateTimeTextField.text = viewModel?.dateTimeText
        viewModel?.datePicker.addTarget(self, action: #selector(CreateTaskTableViewController.dateChange(datePicker:)), for: .valueChanged)
        dateTimeTextField.inputView = viewModel?.datePicker
    }

    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        dateTimeTextField.text = dateFormatter.string(from: viewModel!.datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func done() {
        let title = titleTextField.text!
        let typeEmoji = TagLabel.text!
        let taskDescrip = descriptionTextField.text!
        let time = Time(context: CoreDataStack.shared.context)
        time.startDate = self.viewModel!.datePicker.date as NSDate
        
        if editMode{
            task?.title = title
            task?.taskDescrip = taskDescrip
            task?.typeEmoji = typeEmoji
            task?.taskTime = time
        }else{
            let task = Task(context: CoreDataStack.shared.context)
            task.title = title
            let tagName = tagList.getTag(tagEmoji: typeEmoji)
            task.typeEmoji = tagName.tagName
            
            task.taskDescrip = taskDescrip
            task.taskTime = time
            task.checked = false
            print(task.typeEmoji!)
            
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        titleTextField.text = task?.title
        descriptionTextField.text = task?.taskDescrip
        let dateTime = task!.taskTime.startDate
        datePicker.setDate(dateTime as Date, animated: false)
        dateTimeTextField.text = dateFormatter.string(from: dateTime as Date)
        
        let tagList = TagList()
        
        tagName.text = tagList.getTag(tagEmoji: task?.typeEmoji ?? "").tagName
        TagLabel.text = tagList.getTag(tagEmoji: task?.typeEmoji ?? "").tagEmoji
    }
}

extension CreateTaskTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = TagViewController.instantiate()
           
            let tag = tagList.getTag(tagEmoji: task?.typeEmoji ?? "")
            vc.tagViewModel.setTag(tag:tag)
            vc.tagViewModel.createVC = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

