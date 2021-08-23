//
//  MovieDetailOverviewPropertyView.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 24.08.2021.
//

import UIKit
import LBTATools

final class MovieDetailOverviewPropertyView: UIView {
    private let keyLabel = Label(text: nil, type: .body3, weight: .bold, color: .tintTertiary)
    private let valueLabel = Label(text: nil, type: .body2, weight: .medium, color: .tintSecondary, numberOfLines: 0)
    private let separator = UIView(backgroundColor: Color.separator.value)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(
            keyLabel,
            valueLabel, alignment: .leading
        ).withMargins(Sizing.paddingRow)
        
        addSubview(separator)
        separator.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: Sizing.paddingRow.left, bottom: 0, right: 0),
            size: .init(width: 0, height: 1)
        )
    }
    
    func setData(key: String, value: String) {
        keyLabel.setData(text: key.uppercased())
        valueLabel.setData(text: value)
    }
    
    func setData(isHiddenSeparator: Bool) {
        separator.isHidden = isHiddenSeparator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
