//
//  CreateTaskViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 8/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit




class CreateTaskViewController: UIViewController, Storyboarded {

    var coordinator: EventdFlow?
    
    @IBOutlet weak var emojiTag: UIButton!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    

    private var datePicker : UIDatePicker?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiTag.isEnabled = false
        
        doneBarButton.isEnabled = false
        
        //Disable Done button if titletextfield is empty
        titleTextField.addTarget(self, action: #selector(textFileIsNotEmpty), for:.editingChanged)
        
        setDatePicker()
    }
    
    @objc func textFileIsNotEmpty(textField: UITextField){
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let title = titleTextField.text, !title.isEmpty
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
    
    
    @IBAction func done() {
        coordinator?.backToEvent(Task(title: titleTextField.text!, typeEmoji: emojiTag.titleLabel!.text!, description: descriptionTextField.text!, date: "Monday", time: "09:00", checked: false))
        
// navigationController?.popViewController(animated: true)
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
    
    fileprivate func setDatePicker() {
        dateTimeTextField.tintColor = UIColor .clear
        
        //default dateTimeTextField as current time
        let currentDateTime = Date()
        let currentDateTimeFormatter = DateFormatter()
        currentDateTimeFormatter.dateFormat = "HH:mm E, d MMM"
        
        dateTimeTextField.text = currentDateTimeFormatter.string(from: currentDateTime)
        
        datePicker = UIDatePicker()
        datePicker?.addTarget(self, action: #selector(CreateTaskViewController.dateChange(datePicker:)), for: .valueChanged)
        dateTimeTextField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateTaskViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTimeTextField.inputView = datePicker
    }

}
