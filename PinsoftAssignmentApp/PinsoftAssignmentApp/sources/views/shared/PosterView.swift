//
//  PosterView.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import LBTATools
import Nuke

final class PosterView: UIView {
    enum `Type` {
        case half
        case detail
        
        var size: CGSize {
            switch self {
            case .half:
                return Sizing.posterViewHalf
            case .detail:
                return Sizing.posterViewDetail
            }
        }
        
        var cornerRadiues: CGFloat {
            switch self {
            case .half:
                return Sizing.cornerRadius10pt
            case .detail:
                return Sizing.cornerRadius12pt
            }
        }
    }
    
    private let imageView = UIImageView(contentMode: .scaleAspectFill)
    
    private let label = Label(text: nil, type: .title3, weight: .bold, color: .tintSecondary, alignment: .center, numberOfLines: 5)
    private let backgroundView = UIView(backgroundColor: Color.fillPrimary.value) // for scale transform
    
    init(type: Type) {
        super.init(frame: CGRect.zero)
        
        let aspectRatio = type.size.width / Sizing.posterViewBase.width
        
        layer.cornerRadius = type.cornerRadiues
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        clipsToBounds = true
        
        withSize(type.size)
        
        backgroundView.withSize(Sizing.posterViewBase)
        backgroundView.addCenterInSuperview(superview: self)
        
        label.withWidth(Sizing.posterViewBase.width - (2 * Sizing.space10pt))
        label.addCenterInSuperview(superview: backgroundView)
        
        imageView.addFillSuperview(superview: self)
        
        backgroundView.transform = CGAffineTransform(scaleX: aspectRatio, y: aspectRatio)
    }
    
    func setData(imageUrl: String?, name: String) {
        imageView.isHidden = true
        
        if let imageUrl = imageUrl,
           let url = URL(string: imageUrl) {
            Nuke.loadImage(
                with: url,
                options: .init(
                    transition: .fadeIn(duration: 0.33)
                ),
                into: imageView
            ) { [weak self] (result: Result<ImageResponse, ImagePipeline.Error>) in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success:
                    self.imageView.isHidden = false
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        label.setData(text: name)
    }
    
    func imageDownloadCancel() {
        Nuke.cancelRequest(for: imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
