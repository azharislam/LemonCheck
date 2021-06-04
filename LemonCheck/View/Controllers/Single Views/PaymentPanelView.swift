//
//  PaymentPanelView.swift
//  LemonCheck
//
//  Created by Az on 08/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

@IBDesignable

class PaymentPanelView: UIViewController {
    
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var topLine: UIView!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    var paymentCallback: (() -> Void)?
    var backCallBack: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        configureView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.height * 0.6
        self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.4, width: width, height: height)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag view upwards
        guard translation.y >= 0 else { return }
        
        // Setting x as 0 because we don't want users to move the frame sideways, only straight up and down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    private func configureView() {
        applePayButton.layer.cornerRadius = 16
        topLine.layer.cornerRadius = 8
    }
    
    @IBAction func applePayTapped(_ sender: Any) {
        if let callback = paymentCallback {
            callback()
        }
    }

}
