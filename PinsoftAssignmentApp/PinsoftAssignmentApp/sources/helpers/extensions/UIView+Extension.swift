//
//  UIView+Extension.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import LBTATools

extension UIView {
    func addCenterInSuperview(superview: UIView, size: CGSize = .zero) {
        superview.addSubview(self)
        
        centerInSuperview(size: size)
    }
    
    open func addFillSuperview(superview: UIView,padding: UIEdgeInsets = .zero) {
        superview.addSubview(self)
        
        fillSuperview(padding: padding)
    }
}
