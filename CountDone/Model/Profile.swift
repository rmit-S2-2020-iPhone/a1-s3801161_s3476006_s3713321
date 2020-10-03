//
//  Profile.swift
//  CountDone
//
//  Created by Changyu on 3/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation

class _Profile{
    var studentPhoto = ""
    var studentName = ""
    var studentEmail = ""
    var studentIntroduction = ""
    
    init(studentPhoto: String, studentName: String, studentEmail: String, studentIntroduction: String) {
        self.studentPhoto = studentPhoto
        self.studentName = studentName
        self.studentEmail = studentEmail
        self.studentIntroduction = studentIntroduction
    }
    
}
