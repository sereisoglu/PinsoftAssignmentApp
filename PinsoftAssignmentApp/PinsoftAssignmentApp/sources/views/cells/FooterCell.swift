//
//  FooterCell.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import LBTATools

final class FooterCell: UICollectionReusableView {
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activityIndicatorView.addCenterInSuperview(superview: self)
    }
    
    func setData(animating: Bool) {
        activityIndicatorView.animating = animating
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
