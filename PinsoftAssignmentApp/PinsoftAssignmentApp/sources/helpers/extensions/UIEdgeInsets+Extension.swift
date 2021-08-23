//
//  UIEdgeInsets+Extension.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit

extension UIEdgeInsets {
    static public func linearSides(v vertical: CGFloat, h horizontal: CGFloat) -> UIEdgeInsets {
        return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
