//
//  PaymentPanelView.swift
//  LemonCheck
//
//  Created by Az on 08/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class PaymentPanelView: UIView {
    
    @IBOutlet weak var applePayButton: UIButton!
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 18
    }
    
    @IBAction func applePayTapped(_ sender: Any) {
        
    }
    
}
