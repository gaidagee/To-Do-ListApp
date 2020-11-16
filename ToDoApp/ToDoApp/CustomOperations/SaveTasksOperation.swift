//
//  SaveTasksOperation.swift
//  ToDoApp
//
//  Created by Gaida  on 16/11/2020.
//

import Foundation
import UIKit

class SaveTasksOperation: Operation {
   
    let taskURL : URL
    let tasks : [Tasks]
    
    enum State: String {
         case isReady
         case isExecuting
         case isFinished
     }
    
    override var isAsynchronous: Bool { true }
    override var isExecuting: Bool { operationsState == .isExecuting }
    override var isFinished: Bool {
        if isCancelled && operationsState != .isExecuting { return true }
        return   operationsState == .isFinished
        }
  
    
    var operationsState: State = .isReady {
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: operationsState.rawValue)
        }
    }
    
    
    
    init(taskURL: URL, tasks:[Tasks]) {
        self.taskURL = taskURL
        self.tasks = tasks
    }
    
    
    override func start() {
        operationsState = .isExecuting
        save()

    }
    private func save(){
        let encoder = PropertyListEncoder()
        do {
            let data: Data = try encoder.encode(self.tasks)
            try data.write(to: self.taskURL)
            print("Saved lists!")
        } catch {
            print("Failed to save lists. \(error)")
            let vc = ListsViewController()
            vc.reportError(title: "Error", message: "Failed to save data")
        }
    }
    
    
}
