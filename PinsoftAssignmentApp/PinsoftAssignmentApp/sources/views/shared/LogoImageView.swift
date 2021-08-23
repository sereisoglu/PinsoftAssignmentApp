//
//  LogoImageView.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 24.08.2021.
//

import UIKit
import LBTATools

final class LogoImageView: UIView {
    private let imageView = UIImageView(contentMode: .scaleAspectFit)
    
    init() {
        super.init(frame: CGRect.zero)
        
        imageView.image = UIImage(named: "pinsoft-logo") ?? UIImage()
        imageView.tintColor = Color.tintWhite.value
        
        withSize(.init(width: 300, height: 62))
        
        imageView.addFillSuperview(superview: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
