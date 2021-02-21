//
//  VerifyVehicleViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 09/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Foundation


class VerifyVehicleViewController: UIViewController {
    
    @IBOutlet weak var paymentPanel: PaymentPanelView!
    @IBOutlet weak var vehiclePanel: VerifyPanelView!
    @IBOutlet weak var questionStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    private let service = LCNetworkRequest()
    private var vehicle: MOTCheck?
    var carMake: String?
    var carColour: String?
    var carYear: String?
    var vrm: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        self.configureView()
        self.configureCallbacks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        questionStackView.isHidden = true
        questionLabel.isHidden = true
        paymentPanel.isHidden = false
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        paymentPanel.isHidden = true
        yesButton.layer.cornerRadius = 8
        noButton.layer.cornerRadius = 8
        noButton.layer.borderWidth = 1
        yesButton.layer.borderWidth = 1
        noButton.layer.borderColor = UIColor.darkGray.cgColor
        yesButton.layer.borderColor = UIColor.darkGray.cgColor
        paymentPanel.layer.cornerRadius = 18
        self.vehiclePanel.configureLabels(vrm: self.vrm, make: self.carMake, year: self.carYear, colour: self.carColour)
    }
    
    private func configureCallbacks() {
        paymentPanel.paymentCallback = {
            self.service.getFullVehicleDataFrom(regNumber: VehicleInput.shared.reg!) { [weak self] (response, error) in
                guard let self = self else {return}
                if let response = response {
                    if let rgVC = ResultsViewController.instantiate() {
                        self.navigationController?.pushViewController(rgVC, animated: true)
                        rgVC.vehicle = response
                    }
                } else {
                    print("Cannot find vehicle")
                }
            }
        }
        paymentPanel.backCallBack = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
