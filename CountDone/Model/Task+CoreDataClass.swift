//
//  Task+CoreDataClass.swift
//  CountDone
//
//  Created by Fanwei Wang on 11/9/20.
//  Copyright © 2020 G33. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
//    init(title: String, typeEmoji:String,description:String,time:Time,checked:Bool) {
//        self.title = title
//        self.typeEmoji = typeEmoji
//        self.taskDescrip = description
//        self.taskTime = time
//        self.checked = checked
//    }
    
    struct User: Decodable {
        var id: Int
        var username: String
        var email: String
        var description: String
        var photo: String
    }
    
    struct Task: Decodable {
        var id: Int
        var title: String
        var taskDescription: String
        var taskTime: Time
        var checked: Bool
        var typeEmoji: String
        var user_id: Int
    }
    
    extension Task: Encodable {
        private enum CodingKeys: CodingKey {
            case id
            case title
            case taskDescription
            case taskTime
            case checked
            case typeEmoji
            case user_id
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(taskDescription, forKey: .taskDescription)
            try container.encode(taskTime, forKey: .taskTime)
            try container.encode(checked, forKey: .checked)
            try container.encode(typeEmoji, forKey: .typeEmoji)
            try container.encode(user_id, forKey: .user_id)
        }
    }
    
    extension User: Encodable {
        private enum CodingKeys: CodingKey {
            case id
            case username
            case email
            case description
            case photo
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(username, forKey: .username)
            try container.encode(email, forKey: .email)
            try container.encode(description, forKey: .email)
            try container.encode(photo, forKey: .photo)
        }
    }
    
    // reference: https://www.jianshu.com/p/d7ba741e6009
    func getJson() {
        guard let json_url = Bundle.main.url(forResource: "http://ipse-33-290502.appspot.com/users/duanxinhuan@163.com", withExtension: nil),
            let data = try? Data.init(contentsOf: json_url) else {
                fatalError("json fetch failed")
        }
        
        let decoder = JSONDecoder()
        guard let task = try? decoder.decode([tasks].self, from: data) else {
            fatalError("json decode failed")
        }
        reloadData()
    }
    
    func encodeJson<E: Encodable> (withJSONOBject object: E) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let encodeData = try? encoder.encode(object),
            let jsonText = String(data: encodeData, encoding: .utf8) else {
                fatalError("`Json encode failed`")
        }
        reloadData()
    }
    
    func toggleCheck(){
        checked = !checked
    }
}
