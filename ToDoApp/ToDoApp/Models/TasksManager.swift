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
        let queue = OperationQueue()
           queue.addOperation {
        let encoder = PropertyListEncoder()
        
        do {
            let data: Data = try encoder.encode(self.tasksList)
            try data.write(to: self.tasksURL)
            print("Saved lists!")
        } catch {
            print("Failed to save lists. \(error)")
            self.reportError(title: "Error", message: "Failed to save data")
        }
           }
    }
    
    func load() {
        
        let queue = OperationQueue()
           queue.addOperation {
            
        let decoder = PropertyListDecoder()
        
        do {
            let data: Data = try Data(contentsOf: self.tasksURL)
            let toDoLitst: [Tasks] = try decoder.decode([Tasks].self, from: data)
            self.tasksList = toDoLitst
            print("Loaded list!!")
        } catch {
            
            print("Failed to load . \(error)")
            self.reportError(title: "Error", message: "Failed to load data")
           
        }
           }
    }
    
    func reportError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        
        }
                alert.addAction(okAction)
                let vc = ListsViewController()
                vc.present(alert, animated: true, completion: nil)
    
    }
    

    
    
}
