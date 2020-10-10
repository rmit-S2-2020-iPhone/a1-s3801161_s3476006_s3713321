//
//  CreateTaskViewModel.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/11.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit

class CreateTaskViewModel{
    var task:Task?
    var editMode:Bool
    var datePicker: UIDatePicker
    let context = CoreDataStack.shared.context
    var dateTimeText:String
    
    init(editMode:Bool ){
        self.editMode = editMode
        self.datePicker = UIDatePicker()
        if(!editMode){
            let currentDateTime = Date()
            let currentDateTimeFormatter = DateFormatter()
            currentDateTimeFormatter.dateFormat = "HH:mm E, d MMM"
            self.dateTimeText = currentDateTimeFormatter.string(from: currentDateTime)
        }
        else{
            self.dateTimeText = "lol"
        }
       
    }
    
    func updateTimeText(){
        
    }
    
   
    
    
}
