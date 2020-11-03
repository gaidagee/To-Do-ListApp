//
//  ViewController.swift
//  ToDoApp
//
//  Created by Gaida  on 03/11/2020.
//

import UIKit

class ListsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var TasksManagerList : TaskManager!
    var selectedTask: Tasks!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(TasksManagerList.rr)
        tableView.delegate = self
        tableView.dataSource = self
//         print("\reererere== \(TasksManagerList.tasksList)")
        if TasksManagerList.tasksList.isEmpty{
            print("\n\n -*******EMPTTYYY*********--- \n\n ")

        }else{ for i in TasksManagerList.tasksList {
            print("\n\n -*******LIST VIEW*********--- \n\n \(i.title)\n\n")
        }}
       
            
      
    }
 
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        switch segue.identifier {
//        case "goToDetailsTasks":
//
//            let addTasksViewController = segue.destination as! TasksDetailsViewController
//            addTasksViewController.TasksManagerList = TasksManagerList
//
//        default:
//            print("error")
//
//        }
//
//
//    }


}
extension ListsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return TasksManagerList.tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        let task = TasksManagerList.tasksList[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTask = TasksManagerList.tasksList[indexPath.row]
       // print("Im selected")
       // performSegue(withIdentifier: "showDetail", sender: indexPath)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToDetailsTasks":
       
                   let addTasksViewController = segue.destination as! TasksDetailsViewController
                   addTasksViewController.TasksManagerList = TasksManagerList
       
        case "showDetail":
            if let row = tableView.indexPathForSelectedRow?.row {
                selectedTask = TasksManagerList.tasksList[row]
                print("Im selected: \(TasksManagerList.tasksList[row].title)")
                let addTasksViewController = segue.destination as! TasksDetailsViewController
                addTasksViewController.AddTaskViewUI.TitleField.textColor = .red
                addTasksViewController.AddTaskViewUI.datePicker.isEnabled = false
                addTasksViewController.AddTaskViewUI.TitleField.text = selectedTask.title
                addTasksViewController.TasksManagerList = TasksManagerList
            }

//
        default:
            print("error")
    }
    }
    
}



