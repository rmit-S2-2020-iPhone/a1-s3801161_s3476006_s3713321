//
//  StartViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import Moya

class LoginViewController: UIViewController,Storyboarded {
    var coordinator: StartFlow?
    var events = [Task]()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        let t = Time(context: CoreDataStack.shared.context)
        t.startDate = NSDate()
        
        
        
        EventManager.manager.updateEvent(id: 1, checked: true, taskDescription: "I am happy", title: "Fuel up", typeEmoji: "sport", taskTime: t)
        EventManager.manager.createEvent(checked: false, taskDescription: "I am sad", title: "gogogo", typeEmoji: "laugh", taskTime: t)
        EventManager.manager.requestEvent()
        EventManager.manager.deleteEvent(id: 5)
        
        

//        let Date = try! util.StringToDate(dateString: "09/10/2020, 16:55:59")
//        print(Date)
        
        
        
        super.viewDidLoad()
//        setupUI()
    }
    
//    // MARK: - Actions
    @IBAction func login(_ sender: Any) {
        coordinator?.coordinateToTabBar()
    }
    
    // MARK: - Properties
    

    
    

    
}


