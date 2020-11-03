//
//  Tasks.swift
//  ToDoList
//
//  Created by Gaida  on 02/11/2020.
//

import Foundation


class Tasks: Equatable, Codable{
    
 
    static func == (lhs: Tasks, rhs: Tasks) -> Bool {
        return lhs.title == rhs.title
            && lhs.completed == rhs.completed
            && lhs.dueDate == rhs.dueDate
            && lhs.Description == rhs.Description
    }
    
        
    var title: String = ""
    var completed : Bool = false
    var dueDate : Date = Date()
    var Description :String = ""
    
    enum CountdownResponse {
        case isFinished(time:String)
        case notFinished(time: String)
    }
    private static let dateComponentFormatter: DateComponentsFormatter = {
           var formatter = DateComponentsFormatter()
           formatter.allowedUnits = [.day, .hour, .minute,]
           formatter.unitsStyle = .short
           return formatter
       }()
    
    var dateInterval: Date {
        let currentDate = Date()
        let comp = Calendar.current.dateComponents([.day,.hour,], from: currentDate, to: dueDate)
        return Calendar.current.date(byAdding: comp, to: dueDate)!

        }
    
    
    var timeRemaining: CountdownResponse {
       let now = Date()
        let expirationDate = dateInterval
      
        if expirationDate <= now {
           // let timeRemaining = Tasks.dateComponentFormatter.string(from: now, to: dateInterval)!
            let timeRemaining = Calendar.current.dateComponents([.day,.hour,.minute], from: now, to: dateInterval)
            let timeresult = check(date: timeRemaining, response: "Finished")
            return .isFinished(time: timeresult)
            //
        } else {
            let timeRemaining = Calendar.current.dateComponents([.day,.hour,.minute], from: now, to: dateInterval)
            let timeresult = check(date: timeRemaining, response: "Still")
            return .notFinished(time: timeresult)
        }

//        if dateInterval.date ?? Date() <= now {
//            let timeRemaining = Tasks.dateComponentFormatter.string(from: now, to: dateInterval.date!)!
//            return .isFinished(time: timeRemaining)
//
//            } else {
//                let timeRemaining = Tasks.dateComponentFormatter.string(from: now, to: dateInterval.date ?? dueDate)!
//                return .result(time: timeRemaining)
//            }
        }
    
    func check(date: DateComponents, response: String) -> String{
        guard let Remainingdays = date.day,
                         let RemainingHours = date.hour,
                         let RemainingMinutes = date.minute else{
                       return "none"
                   }
                   let days = abs(Remainingdays)
                   let hours = abs(RemainingHours)
                   let mins = abs(RemainingMinutes)
        
            let string = response == "Finished" ? "due passed" : "due in"
        
                   if days >= 1 {
                  return ("\(string) : \(days) Days ")
                   } else if hours > 0 {
                   return "\(string) : \(hours) hours "
                   } else {
                   return "\(string)  : \(mins) mints "
       
                   }
    }
    
    init(title: String,completed:Bool, date:Date,desc:String) {
        self.title = title
        self.completed = completed
        self.dueDate = date
        self.Description = desc

    }
}
