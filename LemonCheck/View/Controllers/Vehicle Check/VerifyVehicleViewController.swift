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
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var goToResultsButton: UIButton!
    @IBOutlet weak var regSearchField: UITextField!
    @IBOutlet weak var ApplePayBtn: UIButton!
    @IBOutlet weak var regLabel: UILabel!
    @IBOutlet weak var yearAndMake: UILabel!
    @IBOutlet weak var bgVerifyImage: UIImageView!
    @IBOutlet weak var verifyTextImage: UIImageView!
    @IBOutlet weak var buyNowPanel: UIView!
    
    private let service = LCNetworkRequest()
    private var vehicle: MOTCheck?
    private var carMake = ""
    private var carColour = ""
    private var carYear = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        buyNowPanel.layer.cornerRadius = 18
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.getDVLAdata()
            }
        }
    }
    
    func setView() {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func ApplePayBtn(_ sender: Any) {
        
        // Here we make the network call before we open the new view. This is so everything is loaded before the new view is loaded. We pass the vehicle response from the API and assign it to the vehicle instance in the Results, meaning the results will have the users vehicle search ready to access when the new view is opened.
        
        service.getFullVehicleDataFrom(regNumber: VehicleInput.shared.reg!) { [weak self] (response, error) in
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
                    }
                    
                    if let colour = json["colour"] as? String {
                        carColour = colour
                        colourLabel.text = carColour
                    }
                    
                    if let year = json["yearOfManufacture"] as? Int {
                        carYear = year
                        yearAndMake.text = String("\(carYear) \(carMake)")
                        print(year)
                    }
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
