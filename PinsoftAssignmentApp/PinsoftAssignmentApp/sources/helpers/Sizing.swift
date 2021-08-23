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
    
    static let space2pt: CGFloat = 2
    static let space5pt: CGFloat = 5
    static let space8pt: CGFloat = 8
    static let space10pt: CGFloat = 10
    static let space11pt: CGFloat = 11
    static let space12pt: CGFloat = 12
    static let space15pt: CGFloat = 15
    static let space16pt: CGFloat = 16
    static let space20pt: CGFloat = 20
    
    // MARK: - Corner Radius
    
    static let cornerRadius6pt: CGFloat = 6
    static let cornerRadius10pt: CGFloat = 10
    static let cornerRadius12pt: CGFloat = 12
    static let cornerRadius20pt: CGFloat = 20
    
    // MARK: - Ring
    
    static let RING_WIDTH: CGFloat = (2 * RING_RADIUS) + RING_LINE_WIDTH
    static let RING_RADIUS: CGFloat = 360 / 2
    static let RING_LINE_WIDTH: CGFloat = 75
    static let RING_LINE_POSITION: CGFloat = RING_WIDTH / 2
    
    static let RING_DEFAULT_WIDTH: CGFloat = 100
    static let RING_DEFAULT_ASPECT_RATIO: CGFloat = RING_DEFAULT_WIDTH / RING_WIDTH
    static let RING_DEFAULT_RADIUS: CGFloat = RING_RADIUS * RING_DEFAULT_ASPECT_RATIO
    static let RING_DEFAULT_LINE_WIDTH: CGFloat = RING_LINE_WIDTH * RING_DEFAULT_ASPECT_RATIO
    static let RING_DEFAULT_LINE_POSITION: CGFloat = RING_LINE_POSITION * RING_DEFAULT_ASPECT_RATIO

    // MARK: Poster Views
    
    static let posterViewAspectRatio: CGFloat = 3 / 2
    static let posterViewBase: CGSize = .init(width: 200, height: 300)
    static var posterViewHalf: CGSize = .init(width: twoColumns, height: twoColumns * posterViewAspectRatio)
    static var posterViewDetail: CGSize = {
        let width: CGFloat = deviceSize.width * (60 / 100)
        return CGSize.init(width: width, height: width * posterViewAspectRatio)
    }()
    
    static let paddingRow: UIEdgeInsets = .linearSides(v: Sizing.space11pt, h: Sizing.space15pt)
}
