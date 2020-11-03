//
//  protocols.swift
//  ToDoApp
//
//  Created by Gaida  on 03/11/2020.
//

import Foundation


protocol TasksDetaileDelegate: class {
    
    func GetDate(date: Date)
    func GetNewTask(title:String,
                    date: Date,
                    desc: String)
}
