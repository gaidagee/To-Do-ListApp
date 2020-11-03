//
//  TasksDetailsViewController.swift
//  ToDoApp
//
//  Created by Gaida  on 03/11/2020.
//

import UIKit

class TasksDetailsViewController: UIViewController {

    var TasksManagerList : TaskManager!

    let AddTaskViewUI = AddTaskView()
    var task : Tasks!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        AddTaskViewUI.delegate = self

    }
    
    override func loadView() {
        view = AddTaskViewUI
       }

}
extension TasksDetailsViewController :TasksDetaileDelegate{
    

    
    func GetDate(date: Date) {
        print("From the view controller")
        print(date)
        
    }
    
    func GetNewTask(title: String, date: Date, desc: String) {
     //   print("title \(title) date \(date) desc \(desc)")
        performSegue(withIdentifier: "showTasksList", sender: nil)
        task = TasksManagerList.addNewTask(title: title, date: date, desc: desc)
    

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTasksList":
            let listTableViewController = segue.destination as! ListsViewController
            listTableViewController.TasksManagerList = TasksManagerList
//            delegate = listTableViewController
            for i in TasksManagerList.tasksList {
                            print("\n\n -****************--- \n \(i)\n\n")
                        }
        default:
            print("error")
        }
    }
    
    
}
