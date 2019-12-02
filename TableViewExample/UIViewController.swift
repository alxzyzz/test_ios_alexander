//
//  UIImageView.swift
//  TableViewExample
//
//  Created by Baxten on 29/11/19.
//  Copyright © 2019 Christopher Hannah. All rights reserved.
//

import Foundation
import UIKit



var vSpinner : UIView?


extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


extension UIViewController {
    
    func presentVC(_ controller: UIViewController, modalPresentationStyle: UIModalPresentationStyle? = nil , animated: Bool, completion: (()->())? = nil) {
        
        if #available(iOS 13.0, *), modalPresentationStyle == nil {
            controller.modalPresentationStyle = .overFullScreen
        } else if let style: UIModalPresentationStyle = modalPresentationStyle {
            controller.modalPresentationStyle = style
        }
        
        self.present(controller, animated: animated, completion: completion)
        
    }
    
}
