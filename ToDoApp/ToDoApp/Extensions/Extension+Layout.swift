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
}
