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
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var regLabel: UILabel!
    @IBOutlet weak var paymentPanel: PaymentPanelView!
    @IBOutlet weak var vehiclePanel: UIView!
    
    private let service = LCNetworkRequest()
    private var vehicle: MOTCheck?
    private var carMake = ""
    private var carColour = ""
    private var carYear = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func configureView() {
        vehiclePanel.layer.cornerRadius = 18
        vehiclePanel.layer.borderColor = UIColor.yellow.cgColor
        vehiclePanel.layer.borderWidth = 2
        paymentPanel.layer.cornerRadius = 18
        paymentPanel.callback = {
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
    }
    
    // MARK:- Network call to DVLA API
    
    func getDVLAdata() {
        NetworkManager.downloadPlayerProfile {
            jsonData in guard let jData = jsonData else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: jData, options: []) as? [String: Any] {
                    if let registrationNumber = json["registrationNumber"] as? String {
                        print(registrationNumber)
                        regLabel.text = VehicleInput.shared.reg!
                    }
                    
                    if let make = json["make"] as? String {
                        carMake = make
                        makeLabel.text = carMake
                    }
                    
                    if let colour = json["colour"] as? String {
                        carColour = colour
                        colourLabel.text = carColour
                    }
                    
                    if let year = json["yearOfManufacture"] as? Int {
                        carYear = year
                        yearLabel.text = "\(carYear)"
                        print(year)
                    }
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
