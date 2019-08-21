//
//  UIViewControllerExtention.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

var loader : UIView?

extension UIViewController {
    
    func showSingleActionAlertMessage(message: String, handler: (() -> Void)?) {
        let alertController = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default) { alertAction in
            handler?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSpinner(onView : UIView) {
        let loaderView = UIView.init(frame: onView.bounds)
        loaderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = loaderView.center
        
        DispatchQueue.main.async {
            loaderView.addSubview(activityIndicator)
            onView.addSubview(loaderView)
        }
        
        loader = loaderView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            loader?.removeFromSuperview()
            loader = nil
        }
    }
    
    
    
}

