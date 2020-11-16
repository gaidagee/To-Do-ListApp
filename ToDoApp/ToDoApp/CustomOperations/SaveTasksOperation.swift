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
    let tasks : Tasks
    
    init(taskURL: URL, tasks:Tasks) {
        self.taskURL = taskURL
        self.tasks = tasks
    }
    
    
    
    private func save(){
        
    }
    
    
}
