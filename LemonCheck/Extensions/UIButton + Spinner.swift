//
//  UIButton + Spinner.swift
//  LemonCheck
//
//  Created by Azhar Islam on 16/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func loadingIndicator(show: Bool) {
        let tag = 9876
        if show {
            self.setTitle("", for: .normal)
            let indicator = UIActivityIndicatorView()
            indicator.color = .darkGray
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }}
