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
}
