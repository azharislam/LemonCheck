//
//  PaymentPanelView.swift
//  LemonCheck
//
//  Created by Az on 08/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

@IBDesignable

class PaymentPanelView: UIView {
    
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var topLine: UIView!
    
    var paymentCallback: (() -> Void)?
    var backCallBack: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: PaymentPanelView.className) else {return}
        view.frame = self.bounds
        applePayButton.layer.cornerRadius = 16
        topLine.layer.cornerRadius = 8
        self.addSubview(view)
    }
    
    @IBAction func applePayTapped(_ sender: Any) {
        if let callback = paymentCallback {
            callback()
        }
    }

}
