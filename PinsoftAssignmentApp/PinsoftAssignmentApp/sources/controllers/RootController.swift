//
//  RootController.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit

final class RootController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.brandPrimary.value
        
        let logoView = LogoImageView()
        logoView.addCenterInSuperview(superview: view)
        
        if !(APIService.shared.isReachable) {
            DispatchQueue.main.async {
                AlertUtility.present(
                    title: "No Internet Connection",
                    message: "Check your device's internet connection and try again.",
                    delegate: self
                )
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                let searchController = SearchController()
                let navigationController = UINavigationController(rootViewController: searchController)
                
                navigationController.modalPresentationStyle = .overFullScreen
                self.present(navigationController, animated: false)
            }
        }
    }
}
