//
//  EventService.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/7.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import Moya


enum TaskService{
    // define 4 services for event on API
    case createEvent(checked: Bool, taskDescription: String, title: String, typeEmoji:String, taskTime: Time)
    case deleteEvent(id: Int)
    case updateEvent(id:Int,checked: Bool, taskDescription: String, title: String, typeEmoji:String, taskTime: Time)
    case readEvents(userId: Int)
}

extension TaskService: TargetType{
    
    var baseURL: URL {
        // define base url for api
        return URL(string: "http://ipse-33-290502.appspot.com")!
    }
    
    var path: String {
        //define path for different url
        switch self{
            // 0 stands for no user is update to database(our database rule is from 1 to ...)
            case .createEvent(_,_,_,_,_):
                return "/events/0"
            
            case .updateEvent(let id,_,_,_,_,_):
                return "/events/\(id)"
            case .readEvents(let userId):
                return "/events/\(userId)"
            case .deleteEvent(let Id):
                return "/events/\(Id)"
            }
        }
    
    
    var method: Moya.Method {
        //define methiod for api
        switch self{
            case .createEvent(_,_,_,_,_):
                return .put
            
            case .updateEvent(_,_,_,_,_,_):
                return .post
            case .readEvents(_):
                return .get
            case .deleteEvent(_):
                return .delete
        }
    }

    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self{
        case .createEvent(let checked,let taskDescription,let title,let typeEmoji, let taskTime):
            let startTime = taskTime.startDate
            let timeString = NetWorkUtil.util.dateToString(date: startTime)
            let params = ["title" : title , "taskDescription" : taskDescription, "startDatetime": timeString, "checked": checked, "typeEmoji": typeEmoji,"user_id": NetWorkUtil.util.readCurrentId()] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .updateEvent(_,let checked,let taskDescription,let title,let typeEmoji, let taskTime):
            let startTime = taskTime.startDate
            let timeString = NetWorkUtil.util.dateToString(date: startTime)
            let params = ["title" : title , "taskDescription" : taskDescription, "startDatetime": timeString, "checked": checked, "typeEmoji": typeEmoji,"user_id": NetWorkUtil.util.readCurrentId()] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .readEvents(_):
            return .requestPlain
        case .deleteEvent(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
    



