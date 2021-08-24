//
//  Sizing.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit

struct Sizing {
    // MARK: - General
    
    static let deviceSize: CGSize = UIScreen.main.bounds.size
    
    // MARK: - Column
    
    static let oneColumn: CGFloat = deviceSize.width - (Sizing.space16pt + Sizing.space16pt)
    static let twoColumns: CGFloat = (deviceSize.width - (Sizing.space16pt + Sizing.space12pt + Sizing.space16pt)) / 2
    
    // MARK: - Space
    
    static let space5pt: CGFloat = 5
    static let space10pt: CGFloat = 10
    static let space11pt: CGFloat = 11
    static let space12pt: CGFloat = 12
    static let space15pt: CGFloat = 15
    static let space16pt: CGFloat = 16
    static let space20pt: CGFloat = 20
    
    // MARK: - Corner Radius
    
    static let cornerRadius10pt: CGFloat = 10
    static let cornerRadius12pt: CGFloat = 12
    
    // MARK: Padding
    
    static let paddingRow: UIEdgeInsets = .linearSides(v: Sizing.space11pt, h: Sizing.space15pt)

    // MARK: Poster View
    
    static let posterViewAspectRatio: CGFloat = 3 / 2
    static let posterViewBase: CGSize = .init(width: 200, height: 300)
    static var posterViewHalf: CGSize = .init(width: twoColumns, height: twoColumns * posterViewAspectRatio)
    static var posterViewDetail: CGSize = {
        let width: CGFloat = deviceSize.width * (60 / 100)
        return CGSize.init(width: width, height: width * posterViewAspectRatio)
    }()
}
