//
//  HomeViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Toast_Swift
import KRProgressHUD
import KRActivityIndicatorView

protocol RegSearchDelegate: NSObjectProtocol {
    func verifyCheckFor(vrm: String?)
}


public class VehicleInput {
    public var reg: String? = nil
    public static let shared = VehicleInput()
}

class HomeViewController: UIViewController {
    
    private let VALID_REG_NUM_MSG = "A valid UK registration only contains letters A-Z and numbers 0-9, no special characters should not exceed 8 characters (including whitespace)"
    private let EMPTY_CHARACTERS = "Please enter a valid vehicle registration number"
    private let EXCEED_CHAR_LIMIT_ERR_MSG = "A valid UK registration should not exceed 8 characters (including whitespace)"
    private let INVALID_CHAR_ERR_MESSAGE = "A valid UK registration only contains letters A-Z and numbers 0-9, no special characters"
    private let MULTIPLE_SPACE_ERR_MESSAGE = "A valid UK registration should only contain one whitespace"
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private let service = LCNetworkRequest()
    var user: User?
    
    weak var delegate: RegSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureView() {
        searchButton.layer.cornerRadius = 16
        searchField.layer.cornerRadius = 16
        searchField.layer.borderWidth = 0.2
        searchField.layer.borderColor = UIColor.gray.cgColor
        searchField.clipsToBounds = true
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let userInput = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchFor(input: userInput)
    }
    
    private func searchFor(input: String) {
        
        VehicleInput.shared.reg = input
        self.service.vrm = nil
        if input != "" && (input.count == 8 || (input.count == 7 && !input.contains(" "))){
            KRProgressHUD.show(withMessage: "Searching...")
            delegate?.verifyCheckFor(vrm: input)
            if let rgVC = VerifyVehicleViewController.instantiate() {
                DispatchQueue.global().async {
                    self.service.getDVLAdata { vehicleBasicDetails, error in
                        DispatchQueue.main.async {
                            KRProgressHUD.dismiss()
                            guard let vehicleDetails = vehicleBasicDetails, let regNum = vehicleDetails.registrationNumber else {
                                self.showToastMessage(message: "Please enter a valid UK registration number")
                                return
                            }
                            
                            rgVC.carYear = String(vehicleDetails.yearOfManufacture ?? 0)
                            rgVC.carColour = vehicleDetails.colour ?? ""
                            rgVC.carMake = vehicleDetails.make ?? ""
                            rgVC.vrm = regNum
                            self.navigationController?.pushViewController(rgVC, animated: true)
                        }
                    }
                }
            }
        } else if input == "" {
            showToastMessage(message: EMPTY_CHARACTERS, position: .top)
        } else {
            showToastMessage(message: VALID_REG_NUM_MSG, position: .top)
        }
    }
    
    @IBAction func unwindToHomeVC(unwindSegue: UIStoryboardSegue) {
        
    }
}


extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            searchButton.backgroundColor = UIColor(named: Constants.Colors.inactiveGray)
            return true
        } else if textField.text!.count == 8 {
            showToastMessage(message: EXCEED_CHAR_LIMIT_ERR_MSG)
            return false
        } else if textField.text!.count == 7 && !textField.text!.contains(" ") {
            showToastMessage(message: EXCEED_CHAR_LIMIT_ERR_MSG)
            return false
        }else if string == " " && textField.text!.contains(" ") {
            showToastMessage(message: MULTIPLE_SPACE_ERR_MESSAGE)
            return false
        } else if !isValidCharacter(character: string) {
            showToastMessage(message: INVALID_CHAR_ERR_MESSAGE)
            return false
        } else if string != "" {
            searchButton.backgroundColor = UIColor(named: Constants.Colors.charcoalGray)
        }
        
        return true
    }
    
    private func isValidCharacter(character: String) -> Bool {
        !character.isEmpty && character.range(of: "[^a-zA-Z0-9 ]", options: .regularExpression) == nil
        
    }
    
    private func showToastMessage(message: String, position: ToastPosition = .center) {
        var toastStyle = ToastStyle()
        toastStyle.messageColor = .white
        self.view.makeToast(message, position: position, style: toastStyle)
    }
}
