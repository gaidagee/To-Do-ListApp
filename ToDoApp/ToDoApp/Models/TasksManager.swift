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
    
    var tasksURL: URL = {
        let baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let noteURL = baseURL.appendingPathComponent("toDolist")
        return noteURL
    }()
    
 
    init() {
        load()
        print("\n\n\n\n\n ^%^%^%^ \(tasksURL)")

        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(save),
        name: UIScene.didEnterBackgroundNotification, object: nil)
        
    }

    
    func addNewTask(title: String, completed:Bool, date:Date,desc:String) ->Tasks{
        let task = Tasks(title: title, completed: completed, date:date,desc:desc)
        tasksList.append(task)
        return task
        
    }
    
    func deleteTask(_ task: Tasks) {

            if let index = tasksList.firstIndex(of: task) {
            tasksList.remove(at: index)
                
            }
      
 
    }
    
    
    
    @objc func save() {
        
        let encoder = PropertyListEncoder()
        
        #if DEBUG
        encoder.outputFormat = .xml
        #endif
        
        do {
            let data: Data = try encoder.encode(tasksList)
            try data.write(to: tasksURL)
            print("Saved lists!")
        } catch {
            print("Failed to save lists. \(error)")
        }
    }
    
    func load() {
        
        let decoder = PropertyListDecoder()
        
        do {
            let data: Data = try Data(contentsOf: tasksURL)
            let toDoLitst: [Tasks] = try decoder.decode([Tasks].self, from: data)
            self.tasksList = toDoLitst
            print("Loaded list!!")
        } catch {
            
            print("Failed to load . \(error)")
        }
    }
    
    
    func checkDate(){
//        if Date() > tasksList.da! {
//            if abs(diffComponents.day!) >= 1 {
//                print("Pass your due date \n it passed with \(abs(diffComponents.day!)) Days ago")
//            } else {
//                print("Pass your due date \n it passed with \(abs(diffComponents.hour!)) Hours ago")
//            }
//        } else {
//            print("Due in about \(diffComponents.day) \(diffComponents.hour)")
//        }
    }
    
    
}
