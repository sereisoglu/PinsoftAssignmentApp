//
//  AlertUtility.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit

final class AlertUtility {
    class func present(
        title: String,
        message: String,
        buttonTitle: String = "OK",
        handler: ((UIAlertAction) -> Void)? = nil,
        delegate: UIViewController
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        )
        
        delegate.present(alertController, animated: true, completion: nil)
    }
}
