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
    let arrColors: [UIColor] = [
         UIColor(hue: 15/360, saturation: 39/100, brightness: 56/100, alpha: 1.0) /* #916758 */
        , UIColor(hue: 9/360, saturation: 22/100, brightness: 86/100, alpha: 1.0) /* #ddb4ac */
        , UIColor(hue: 180/360, saturation: 42/100, brightness: 78/100, alpha: 1.0) /* #74c8c8 */
        , UIColor(hue: 75/360, saturation: 3/100, brightness: 95/100, alpha: 1.0), /* #f2f4ec */
         UIColor(hue: 359/360, saturation: 0/100, brightness: 100/100, alpha: 1.0) /* #ffffff */
    ] // Use your color hex

    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var completeButton: UIButton!
    
    @IBOutlet var cellSideView: UIView!
    var cellDelegate: TasksCellDelegate!
    
    var index: Int?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }

    private func customizeUI(){
        
        taskTitle.setFont()
        dueDateLabel.setFont()
        
//        cellSideView.backgroundColor = arrColors.randomElement()
      
        dueDateLabel.font = UIFont.systemFont(ofSize: 15)
        
        self.backgroundColor = UIColor(red: 0.9725, green: 0.9216, blue: 0.8902, alpha: 1.0)
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

