//
//  TasksManager.swift
//  ToDoList
//
//  Created by Gaida  on 02/11/2020.
//

import Foundation
import UIKit

class TaskManager {
    
    var tasksList = [Tasks]()
    
    var rr = "THIS IS TASK MANAGER ACCESSES"
    
    func addNewTask(title: String, date:Date,desc:String) ->Tasks{
        let task = Tasks(title: title, date:date,desc:desc)
        tasksList.append(task)
        return task
        
    }
    
    
}
