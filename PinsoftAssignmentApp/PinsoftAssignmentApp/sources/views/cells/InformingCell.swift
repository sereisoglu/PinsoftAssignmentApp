//
//  InformingCell.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import LBTATools

final class InformingCell: UICollectionViewCell {
    private let headerLabel = Label(text: nil, type: .title2, weight: .bold, color: .tintPrimary, alignment: .center, numberOfLines: 2)
    private let messageLabel = Label(text: nil, type: .body1, weight: .medium, color: .tintSecondary, alignment: .center, numberOfLines: 0)
    
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        hstack(
            stack(
                headerLabel,
                stack(
                    messageLabel
                ).padLeft(Sizing.space20pt).padRight(Sizing.space20pt), spacing: Sizing.space10pt, alignment: .center
            ).withWidth(Sizing.oneColumn), alignment: .center
        )
        
        activityIndicatorView.addCenterInSuperview(superview: self)
        
        headerLabel.alpha = 0
        messageLabel.alpha = 0
    }
    
    func setState(_ state: InformingState) {
        switch state {
        case .data:
            headerLabel.alpha = 0
            messageLabel.alpha = 0
            activityIndicatorView.animating = false
            
        case .emptyOrError(let headerText, let messageText):
            headerLabel.alpha = 1
            messageLabel.alpha = 1
            activityIndicatorView.animating = false
            
            headerLabel.setData(text: headerText)
            messageLabel.setData(text: messageText)

        case .loading:
            headerLabel.alpha = 0
            messageLabel.alpha = 0
            activityIndicatorView.animating = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
