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
    
    private let service = RCNetworkRequest()
    private var vehicle: MOTCheck?
    private var carMake = ""
    private var carColour = ""
    private var carYear = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
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
        print("Apple Pay button pressed")
        if let rgVC = ResultsViewController.instantiate() {
            self.navigationController?.pushViewController(rgVC, animated: true)
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
