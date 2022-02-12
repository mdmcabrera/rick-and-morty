//
//  UIViewController+Extension.swift
//  rick-and-morty-app
//
//  Created by Mar Cabrera on 12/02/2022.
//

import UIKit

extension UIViewController {
    func startActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.color = .blue
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.tag = 100
    }
    
    func stopActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()

        activityIndicator?.removeFromSuperview()
    }
}
