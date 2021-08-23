//
//  SearchItemCell.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import LBTATools

final class SearchItemCell: UICollectionViewCell {
    private let posterView = PosterView(type: .half)
    private let label = Label(text: nil, type: .body1, weight: .bold, color: .tintPrimary, alignment: .center, numberOfLines: 1)
    private let subLabel = Label(text: nil, type: .body2, weight: .medium, color: .tintSecondary, alignment: .center, numberOfLines: 1)

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut, animations: { [self] in
                    transform = isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
                }
            )
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        stack(
            posterView,
            stack(
                label,
                subLabel
            ), spacing: Sizing.space5pt
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        posterView.imageDownloadCancel()
    }

    func setData(item: MovieModel) {
        posterView.setData(imageUrl: item.imageUrl, name: item.name)
        label.setData(text: item.name)
        subLabel.setData(text: item.releasedDate)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
