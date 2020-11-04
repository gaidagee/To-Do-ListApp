//
//  Extension+Layout.swift
//  ToDoList
//
//  Created by Gaida  on 02/11/2020.
//

import Foundation
import UIKit

extension UIView {

func setDimensions(height: CGFloat? = nil , width: CGFloat? = nil) {
    translatesAutoresizingMaskIntoConstraints = false
    if let height = height {
    heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    if let width = width {
    widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
    
    func roundCorners(corners: UIRectCorner, raduis: Int = 8){
        let maskPath1 = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: raduis, height: raduis))
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func allRoundedConrners(radius: CGFloat = 10){
        self.layer.cornerRadius = radius
    }
    
   
}

extension UIColor {
    static var lightPink = UIColor(red: 0.9725, green: 0.9216, blue: 0.8902, alpha: 1.0)
    static var peachyPink = UIColor(red: 0.9373, green: 0.6314, blue: 0.5529, alpha: 1.0) /* #efa18d */
    static var offWhite = UIColor(red: 0.9686, green: 0.9647, blue: 0.9608, alpha: 1.0) /* #f7f6f5 */


}
