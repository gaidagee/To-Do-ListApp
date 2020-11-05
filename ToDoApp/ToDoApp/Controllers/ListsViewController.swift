//
//  ViewController.swift
//  ToDoApp
//
//  Created by Gaida  on 03/11/2020.
//

import UIKit
import UserNotifications
import Lottie

class ListsViewController: UIViewController {
    
    
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var sortingSegmentedControl: UISegmentedControl!{
        didSet {
            sortingSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
           }
    }
        
    @IBOutlet var innderView: UIView!
    
    @IBOutlet var addButtonView: UIView!
    
    @IBOutlet var buttonAnimationView: UIView!
    
    
    var selectedTask: Tasks!
    var TasksManagerList : TaskManager!

    var filteredTasksList = [Tasks]()
    var AlpfilteredTasksList = [Tasks]()
    
    private var isFiltered = false
    private var isGranted = false
    var selectedType: sortType!

    enum sortType {
       
        case Alph
        case date
        case none
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        scheduleLocal()
        configureUI()
   
    }
    
    
    
    //MARK: Helper

    func configureUI(){
        
        print(TasksManagerList.rr)
        filteredTasksList = TasksManagerList.tasksList
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightPeach
        
        view.backgroundColor = .darkGreen
        navigationController?.navigationBar.barTintColor = .darkGreen
        
        addButtonView.backgroundColor = .peachyPink
        addButtonView.allRoundedConrners(radius: 30)
        
        innderView.roundCorners(corners: [.topLeft , .topRight],raduis: 20)
        
      
    }
    
   
 

    @IBAction func sortTypeSelected(_ sender: UISegmentedControl) {

        isFiltered = true
        
        switch sender.selectedSegmentIndex {

        case 0:
            selectedType = .Alph
            filteredTasksList =  filteredTasksList.sorted{
                $0.title < $1.title}
        case 1:
            selectedType = .date
            filteredTasksList = TasksManagerList.tasksList
            filteredTasksList =  filteredTasksList.sorted{
                $0.dueDate < $1.dueDate}
        case 2:
            
                        // do something
            filteredTasksList = TasksManagerList.tasksList
        default:
            print("error in segmented control")
        }
        
        tableView.reloadData()
    }
    
    
   
    
    
    //MARK: Helpers
    
    func checkDate(of task: Tasks) -> String{
        
        let time = task.timeRemaining
        switch  time{
        case .isFinished(let remianTime):
           return remianTime

        case .notFinished(let remianTime):
            return remianTime

        }

    }
    
}
extension ListsViewController: UITableViewDelegate, UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isFiltered ? filteredTasksList.count : TasksManagerList.tasksList.count

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksListTableViewCell", for: indexPath) as! TasksListTableViewCell
       
        let taskList = isFiltered ? filteredTasksList : TasksManagerList.tasksList
        let task = taskList[indexPath.row]
        
        cell.cellDelegate = self
        cell.index = indexPath.row
        
        
        
        let buttonImage: UIImage = task.completed == true ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
        cell.completeButton.setImage(buttonImage, for: .normal)
        cell.taskTitle.text = task.title
        cell.dueDateLabel.text = checkDate(of: task)
        
        
        return cell
    }
    
  
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskList = isFiltered ? filteredTasksList : TasksManagerList.tasksList
        selectedTask = taskList[indexPath.row]
  
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let DeleteAction = makeDeleteContextualAction(forRowAt: indexPath)
        DeleteAction.backgroundColor = .errorRed

        return UISwipeActionsConfiguration(actions: [DeleteAction])
    }
    
   

    //MARK: - Create Delete Contextual Actions
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            let taskList = self.isFiltered ? self.filteredTasksList : self.TasksManagerList.tasksList
            let deletedTask = taskList[indexPath.row]
            self.TasksManagerList.deleteTask(deletedTask)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
    }
    
   
    
}
extension ListsViewController: TasksCellDelegate{
    
    /// function to update the task completion status if the user completed a task. Throguh tasks cell delegate protocol.
    func updateTask(index: Int) {
        let taskList = isFiltered ? filteredTasksList : TasksManagerList.tasksList
        let task = taskList[index]
        
        switch task.completed {
        case false:
            task.completed = true

        case true:
            task.completed = false
        }
        tableView.reloadData()

    }
    

}

extension ListsViewController {
    
    // MARK: - They both show the 'TasksDetailsViewController'
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
      
        case "goToDetailsTasks":     //  case if user add a new task
            
            let addTasksViewController = segue.destination as! TasksDetailsViewController
            addTasksViewController.TasksManagerList = TasksManagerList
            
       
        case "showDetail":           //   case if the user edit an existing task
            let taskList = isFiltered ? filteredTasksList : TasksManagerList.tasksList
            if let row = tableView.indexPathForSelectedRow?.row {
                selectedTask = taskList[row]
                let addTasksViewController = segue.destination as! TasksDetailsViewController
                showTaskDetail(on: addTasksViewController)
            }
            
        default:
            print("error")
        }
    }
    
    /// This function is used to pass the data of the selected task to the TaskDetail VC case in editing mode.
    func showTaskDetail(on vc: TasksDetailsViewController){
        
        let hidden = selectedTask.completed == true ? false : true
        vc.isEditingMode = true
        
        vc.AddTaskViewUI.TitleField.textColor = .red
        vc.AddTaskViewUI.datePicker.isEnabled = false
        
        vc.AddTaskViewUI.HeaderLabel.text = "Edit you task"
        vc.AddTaskViewUI.checkImage.isHidden = hidden
        vc.AddTaskViewUI.TitleField.text = selectedTask.title
        vc.AddTaskViewUI.datePicker.date = selectedTask.dueDate
        vc.AddTaskViewUI.textView.text = selectedTask.Description
        
        vc.selectedTask = selectedTask
        vc.TasksManagerList = TasksManagerList
    }
}

extension ListsViewController {
  
     func scheduleLocal() {
        let nc = UNUserNotificationCenter.current()
        nc.requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted , error) in
            
            if granted {
                self.isGranted = true
                print("Yes Granted")
            } else {
                self.isGranted = false
                print("NO Not granted")
            }
        }
                
        
        let content = UNMutableNotificationContent()
        content.title = "Dont Forget your task !"
        content.body = " You task is close to its due date"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        DispatchQueue.global(qos: .background).async {
            
            for task in self.TasksManagerList.tasksList {
                
            content.body = " You task \(task.title) is close to its due date"
            let taskDate = task.dueDate - 60
            print("Task Date \(taskDate)")
            let components =  Calendar.current.dateComponents([.day, .hour, .minute], from: taskDate)
            print("components \(components)")
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                nc.add(request)
            
        }
        }
       
        
    }
    
     func registerLocal() {
      
    }
}





