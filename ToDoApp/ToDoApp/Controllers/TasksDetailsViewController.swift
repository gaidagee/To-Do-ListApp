//
//  TasksDetailsViewController.swift
//  ToDoApp
//
//  Created by Gaida  on 03/11/2020.
//

import UIKit

class TasksDetailsViewController: UIViewController {

    var isEditingMode = false
    
    var TasksManagerList : TaskManager!
    
    let AddTaskViewUI = AddTaskView()
    
    var selectedTask: Tasks!
    
    var task : Tasks!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        view.backgroundColor = UIColor(red: 0.5176, green: 0.5725, blue: 0.549, alpha: 1.0)
            //UIColor(red: 0.9569, green: 0.9333, blue: 0.9216, alpha: 1.0) /* #f4eeeb */

        AddTaskViewUI.delegate = self

    }
    
    override func loadView() {
        view = AddTaskViewUI
       }
    


}
extension TasksDetailsViewController :TasksDetaileDelegate{
    

    
    func GetDate(date: Date) {
        print(date)
        
    }
    
    func GetNewTask(title: String, date: Date, desc: String) {
        
        switch isEditingMode {
        case false:
            
            performSegue(withIdentifier: "showTasksList", sender: nil)
            task = TasksManagerList.addNewTask(title: title, completed: false, date: date, desc: desc)
            TasksManagerList.save()
            
        case true:
            
            selectedTask.title = AddTaskViewUI.TitleField.text!
            selectedTask.Description = AddTaskViewUI.textView.text!
           
            performSegue(withIdentifier: "showTasksList", sender: nil)

        }
      

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTasksList":
            let listTableViewController = segue.destination as! ListsViewController
            listTableViewController.TasksManagerList = TasksManagerList
            for i in TasksManagerList.tasksList {
                            print("\n\n -****************--- \n \(i)\n\n")
                        }
        default:
            print("error")
        }
    }
    
    
}
