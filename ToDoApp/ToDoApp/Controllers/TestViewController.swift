//
//  TestViewController.swift
//  ToDoApp
//
//  Created by Gaida  on 05/11/2020.
//

import UIKit

class SignIn: UIViewController {
    var TasksManagerList : TaskManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let vc = segue.destination as! ListsViewController
            vc.TasksManagerList = TasksManagerList
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
