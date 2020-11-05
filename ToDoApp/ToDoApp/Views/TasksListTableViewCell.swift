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
    
    let themeColors: [UIColor] = [
        #colorLiteral(red: 0.568627451, green: 0.4039215686, blue: 0.3450980392, alpha: 1),#colorLiteral(red: 0.8666666667, green: 0.7058823529, blue: 0.6745098039, alpha: 1), #colorLiteral(red: 0.4549019608, green: 0.7843137255, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    ]

    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var completeButton: UIButton!
    
    @IBOutlet var cellSideView: UIView!
    var cellDelegate: TasksCellDelegate!
    
    var index: Int?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }

    private func customizeUI(){
       
        taskTitle.setFont()
        dueDateLabel.setFont()
        dueDateLabel.font = UIFont.systemFont(ofSize: 15)
        
        self.cellSideView.backgroundColor = themeColors.randomElement()
        self.backgroundColor = .lightPeach
//        cell.cellSideView.backgroundColor = cell.arrColors.randomElement()
      
      
    }

    @IBAction func CompleteButtonClicked(_ sender: Any) {
     cellDelegate.updateTask(index:index!)
    }
}
extension UILabel{
    func setFont(){
        self.font = UIFont.monospacedSystemFont(ofSize: 19, weight: .medium)

    }
}

