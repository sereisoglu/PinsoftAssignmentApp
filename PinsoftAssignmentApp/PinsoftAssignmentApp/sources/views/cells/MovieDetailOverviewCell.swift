//
//  MovieDetailOverviewCell.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 24.08.2021.
//

import UIKit
import LBTATools

final class MovieDetailOverviewCell: UICollectionViewCell {
    private let MAX_PROPERTY_COUNT = 16
    
    private let propertiesStackView = UIStackView()
    
    private var propertyViews = [MovieDetailOverviewPropertyView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        propertiesStackView.backgroundColor = Color.backgroundGroupedPrimary.value
        propertiesStackView.clipsToBounds = true
        propertiesStackView.layer.cornerRadius = Sizing.cornerRadius10pt
        if #available(iOS 13.0, *) {
            propertiesStackView.layer.cornerCurve = .continuous
        }
        
        propertiesStackView.axis = .vertical
        
        for _ in 0 ..< MAX_PROPERTY_COUNT {
            let propertyView = MovieDetailOverviewPropertyView()
            
            propertyViews.append(propertyView)
            
            propertiesStackView.addArrangedSubview(propertyView)
        }
        
        stack(
            propertiesStackView, spacing: Sizing.space10pt
        )
    }
    
    func setData(properties: [(key: String, value: String)]) {
        var lastPropertyViewIndex = -1
        
        for index in 0 ..< MAX_PROPERTY_COUNT {
            if let property = properties[safe: index] {
                propertyViews[index].isHidden = false
                propertyViews[index].setData(key: property.key, value: property.value)
                
                lastPropertyViewIndex = index
            } else {
                propertyViews[safe: index]?.isHidden = true
            }
        }
        
        propertyViews[safe: lastPropertyViewIndex]?.setData(isHiddenSeparator: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
