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
    
    @IBOutlet var addButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(TasksManagerList.rr)
        self.tableView.reloadData()
        view.backgroundColor = UIColor(red: 0.5176, green: 0.5725, blue: 0.549, alpha: 1.0)
            //UIColor(red: 0.8078, green: 0.8353, blue: 0.8196, alpha: 1.0) /* #ced5d1 */
        addButtonView.backgroundColor = UIColor(red: 0.9725, green: 0.9216, blue: 0.8902, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.backgroundColor = UIColor(red: 0.9725, green: 0.9216, blue: 0.8902, alpha: 1.0)
            //UIColor(hue: 148/360, saturation: 2/100, brightness: 93/100, alpha: 1.0)
        tableView.roundCorners(corners: [.topLeft , .topRight],raduis: 20)
//         print("\reererere== \(TasksManagerList.tasksList)")
        if TasksManagerList.tasksList.isEmpty{
            print("\n\n -*******EMPTTYYY*********--- \n\n ")

        }else{ for i in TasksManagerList.tasksList {
            print("\n\n -*******LIST VIEW*********--- \n\n \(i.title)\n\n")
        }}
       
            
      
    }
    
    /// This function is used to pass the data of the selected task to the TaskDetail VC case in editing mode.
    func showTaskDetail(on vc: TasksDetailsViewController){
        vc.isEditingMode = true
        
        vc.AddTaskViewUI.TitleField.textColor = .red
        vc.AddTaskViewUI.datePicker.isEnabled = false
        
        vc.AddTaskViewUI.HeaderLabel.text = "Edit you task"
        vc.AddTaskViewUI.TitleField.text = selectedTask.title
        vc.AddTaskViewUI.datePicker.date = selectedTask.dueDate
        vc.AddTaskViewUI.textView.text = selectedTask.Description
        
        vc.selectedTask = selectedTask
        vc.TasksManagerList = TasksManagerList
    }
 


}
extension ListsViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return TasksManagerList.tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksListTableViewCell", for: indexPath) as! TasksListTableViewCell
       
        let task = TasksManagerList.tasksList[indexPath.row]
        
        cell.cellDelegate = self
        cell.index = indexPath.row
        
        let buttonImage: UIImage = task.completed == true ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
        cell.completeButton.setImage(buttonImage, for: .normal)
       
        cell.taskTitle.text = task.title
        cell.dueDateLabel.text = checkDate(of: task)
        return cell
    }
    
    func checkDate(of task: Tasks) -> String{
        
        let time = task.timeRemaining
        switch  time{
        case .isFinished(let remianTime):
           return remianTime

        case .notFinished(let remianTime):
            return remianTime

        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTask = TasksManagerList.tasksList[indexPath.row]
  
    }
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

          let DeleteAction = makeDeleteContextualAction(forRowAt: indexPath)
          DeleteAction.backgroundColor = UIColor(hue: 327/360, saturation: 48/100, brightness: 77/100, alpha: 1.0)


          return UISwipeActionsConfiguration(actions: [DeleteAction])
      }
    
   

      //MARK: - Delete Contextual Actions
         private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {

             return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
              let deletedTask = self.TasksManagerList.tasksList[indexPath.row]
              self.TasksManagerList.deleteTask(deletedTask)
              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                  completion(true)
             }
         }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        
        // MARK: - They both show the 'TasksDetailsViewController'
      
        //  case if user add a new task
        case "goToDetailsTasks":
            
            let addTasksViewController = segue.destination as! TasksDetailsViewController
            addTasksViewController.TasksManagerList = TasksManagerList
            
        //   case if the user edit an existing task
        case "showDetail":
            
        if let row = tableView.indexPathForSelectedRow?.row {
            selectedTask = TasksManagerList.tasksList[row]
            let addTasksViewController = segue.destination as! TasksDetailsViewController
            showTaskDetail(on: addTasksViewController)
        }
            
        default:
            print("error")
        }
    }
    
  
    
}
extension ListsViewController: TasksCellDelegate{
    
    /// function to update the task completion status if the user completed a task. Throguh tasks cell delegate protocol.
    func updateTask(index: Int) {
        let task = TasksManagerList.tasksList[index]
        
        switch task.completed {
        case false:
            task.completed = true

        case true:
            task.completed = false
        }
        tableView.reloadData()

    }
    

}


