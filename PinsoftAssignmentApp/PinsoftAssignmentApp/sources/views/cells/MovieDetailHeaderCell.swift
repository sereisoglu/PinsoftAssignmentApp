//
//  MovieDetailHeaderCell.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import LBTATools

final class MovieDetailHeaderCell: UICollectionViewCell {
    private let posterView = PosterView(type: .detail)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        posterView.addCenterInSuperview(superview: self)
    }

    func setData(imageUrl: String?, name: String) {
        posterView.setData(imageUrl: imageUrl, name: name)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
