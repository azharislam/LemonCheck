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
    private var carMake = ""
    private var carColour = ""
    private var carYear = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        self.configureView()
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.getDVLAdata()
            }
        }
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
    
    func configureView() {
        paymentPanel.isHidden = true
        yesButton.layer.cornerRadius = 8
        noButton.layer.cornerRadius = 8
        noButton.layer.borderWidth = 1
        yesButton.layer.borderWidth = 1
        noButton.layer.borderColor = UIColor.darkGray.cgColor
        yesButton.layer.borderColor = UIColor.darkGray.cgColor
        paymentPanel.layer.cornerRadius = 18
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
    
    // MARK:- Network call to DVLA API
    
    func getDVLAdata() {
        NetworkManager.downloadPlayerProfile {
            jsonData in guard let jData = jsonData else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: jData, options: []) as? [String: Any] {
                    if let registrationNumber = json["registrationNumber"] as? String,
                       let make = json["make"] as? String,
                        let colour = json["colour"] as? String,
                        let year = json["yearOfManufacture"] as? Int
                    {
                        carMake = make
                        carColour = colour
                        carYear = year
                        vehiclePanel.configureLabels(vrm: registrationNumber, make: make, year: "\(year)", colour: colour)
                    }
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
