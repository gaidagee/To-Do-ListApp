//
//  Tasks.swift
//  ToDoList
//
//  Created by Gaida  on 02/11/2020.
//

import Foundation


class Tasks{
        
    var title: String = ""
   // var completed : Bool = false
    var date : Date = Date()
    var Description :String = ""
    
    init(title: String, date:Date,desc:String) {
        self.title = title
        self.date = date
        self.Description = desc

    }
}
