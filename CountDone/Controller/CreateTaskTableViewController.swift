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
    let queue = DispatchQueue.main
   
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
    
    static func instantiate(editMode: Bool, task:Task) -> CreateTaskTableViewController{
        
        let vc = CreateTaskTableViewController.instantiate(editMode: editMode)
        vc.viewModel?.task = task
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel!.vc = self
        
        doneBarButton.isEnabled = false
        //Disable Done button if titletextfield is empty
        titleTextField.addTarget(self, action: #selector(textFileIsNotEmpty), for:.editingChanged)
        
        setDatePicker()
        descriptionTextField.text = "I am a Task!"
        
        if viewModel!.editMode == true{
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
    
    fileprivate func setDatePicker() {
        dateTimeTextField.tintColor = UIColor .clear
        dateTimeTextField.text = viewModel?.dateTimeText
        viewModel?.datePicker.addTarget(self, action: #selector(CreateTaskTableViewController.dateChange(datePicker:)), for: .valueChanged)
        dateTimeTextField.inputView = viewModel?.datePicker
    }

    @objc func dateChange(datePicker: UIDatePicker){
        viewModel?.updateTime()
        dateTimeTextField.text = viewModel?.dateTimeText
        view.endEditing(true)
    }
    
    
    
    func now(_ closure: () -> Void) {
        closure()
    }
    
    func later(_ closure: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + 1) {
            closure()
        }
    }
    
    @IBAction func done() {
        let title = titleTextField.text!
        let typeEmoji = TagLabel.text!
        let taskDescrip = descriptionTextField.text!
        let time = Time(context: CoreDataStack.shared.context)
        time.startDate = viewModel!.datePicker.date as NSDate
        
        
        if viewModel!.editMode{
            let _ = viewModel?.done(title: title, typeEmoji: typeEmoji, taskDescrip: taskDescrip, time: time)
            self.coordinator?.backToEvent()
        }else{
           
            
            now {
                guard let _ = self.viewModel?.done(title: title, typeEmoji: typeEmoji, taskDescrip: taskDescrip, time: time)
                    else{
                        print("sorry")
                        return
                }
            }
            let alert = UIAlertController(title: "", message: "uploading your task to api......", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            later{
                self.coordinator?.backToEvent()
                
            }
        }
        
        
        
    }

    
    func setEditDetail(){
        
        let task = viewModel?.task!
        
      
        titleTextField.text = task?.title
        descriptionTextField.text = task?.taskDescrip
        let dateTime = task!.taskTime.startDate
        viewModel!.datePicker.setDate(dateTime as Date, animated: false)
        viewModel?.updateTime()
        dateTimeTextField.text = viewModel?.dateTimeText
        
        tagName.text = TagList.getter.getTag(tagEmoji: task?.typeEmoji ?? "").tagName
        TagLabel.text = TagList.getter.getTag(tagEmoji: task?.typeEmoji ?? "").tagEmoji
    }
}

extension CreateTaskTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = TagViewController.instantiate()
           
            let tag = tagList.getTag(tagEmoji: viewModel?.task?.typeEmoji ?? "")
            vc.tagViewModel.setTag(tag:tag)
            vc.tagViewModel.createVC = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

