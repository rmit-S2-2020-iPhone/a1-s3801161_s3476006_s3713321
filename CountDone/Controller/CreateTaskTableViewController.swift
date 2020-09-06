//
//  CreateTaskTableViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 4/9/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

//class CellClass: UITableViewCell{
//
//}

class CreateTaskTableViewController: UITableViewController,Storyboarded {
    var coordinator: EventdFlow?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!    
//    @IBOutlet weak var emojiTag: UIButton!
    @IBOutlet weak var TagTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    @IBOutlet weak var navigationBar: UINavigationItem!
    var task: Task?
    
    var editMode = false
//    let emojiSelectView = UIView()
//    let emojiTableview = UITableView()
//    var selectedBtn = UIButton()
    
    //hard code
//    var dataSource = [String]()
    
    private var datePicker : UIDatePicker?
    
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
//        emojiTableview.delegate = self
//        emojiTableview.dataSource = self
//        
//        emojiTableview.register(CellClass.self, forCellReuseIdentifier: "Cell")
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
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker!.date)
        let time = Time(startDateComponent: dateComponent)
        
        if editMode{
        task?.title = titleTextField.text!
        task?.description = descriptionTextField.text!
        task?.typeEmoji = TagTextField.text!
        task?.time = Time(startDateComponent: dateComponent)
        }
        
        coordinator?.backToEvent(Task(title: titleTextField.text!, typeEmoji: TagTextField.text! , description: descriptionTextField.text!, time: time, checked: false))
        
        
    }
   
    func editModeOn(){
        editMode = true
    }
    
    func setEditDetail(){
        let cell = coordinator?.currentCell!
        let task = cell?.task!
        
        let calender = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM"
        titleTextField.text = task?.title
        descriptionTextField.text = task?.description
        let dateTime = calender.date(from: task!.time.startDateComponent)
        dateTimeTextField.text = dateFormatter.string(from: dateTime!)
        TagTextField.text = task?.typeEmoji
    }
}



//extension CreateTaskTableViewController{
//
//    func addEmojiSelectView(frames: CGRect) {
//        let window = UIApplication.shared.keyWindow
//        emojiSelectView.frame = window?.frame ?? self.view.frame
//        self.view.addSubview(emojiSelectView)
//
//        emojiTableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
//
//        self.view.addSubview(emojiTableview)
//        emojiTableview.layer.cornerRadius = 5
//
//        emojiSelectView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
//
//        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeEmojiSelectView))
//
//        emojiSelectView.addGestureRecognizer(tapgesture)
//        emojiSelectView.alpha = 0
//
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options: .curveEaseOut, animations: {
//            self.emojiSelectView.alpha = 0.5
//            self.emojiTableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width , height: 200)
//        },completion: nil)
//    }

//    @objc func removeEmojiSelectView(){
//        let frames = selectedBtn.frame
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options: .curveEaseOut, animations: {
//            self.emojiSelectView.alpha = 0
//            self.emojiTableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
//        },completion: nil)
//    }
//    @IBAction func selectTag(_ sender: Any) {
//        dataSource = ["🏃", "🏠", "💼"]
//        selectedBtn = emojiTag
//        addEmojiSelectView(frames: emojiTag.frame)
//
//    }
//}

//extension CreateTaskTableViewController{
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = emojiTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = dataSource[indexPath.row]
//        return cell
//    }
//}
