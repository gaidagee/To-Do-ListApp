//
//  TasksListTableViewCell.swift
//  ToDoApp
//
//  Created by Gaida  on 03/11/2020.
//

import UIKit

protocol TasksCellDelegate {
    func updateTask(index: Int)
}
class TasksListTableViewCell: UITableViewCell {

    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var completeButton: UIButton!
    
    var cellDelegate: TasksCellDelegate!
    
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func CompleteButtonClicked(_ sender: Any) {
     cellDelegate.updateTask(index:index!)
    }
}

