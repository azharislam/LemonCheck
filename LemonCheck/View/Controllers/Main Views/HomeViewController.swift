//
//  HomeViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Toast_Swift

protocol RegSearchDelegate: NSObjectProtocol {
    func verifyCheckFor(vrm: String?)
}


public class VehicleInput {
    public var reg: String? = nil
    public static let shared = VehicleInput()
}

class HomeViewController: UIViewController {
    
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
        if input != "" {
            searchButton.backgroundColor = UIColor(named: Constants.Colors.charcoalGray) //move this
            delegate?.verifyCheckFor(vrm: input)
            if let rgVC = VerifyVehicleViewController.instantiate() {
                DispatchQueue.global(qos: .userInteractive).async {
                    DispatchQueue.main.async { [self] in
                        self.service.getDVLAdata()
                        rgVC.carYear = self.service.carYear
                        rgVC.carColour = self.service.carColour
                        rgVC.carMake = self.service.carMake
                        rgVC.vrm = self.service.vrm
                    }
                }
                self.navigationController?.pushViewController(rgVC, animated: true)
            }
        } else {
            print("Please enter a valid vehicle registration number")
        }
    }
}


extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text!.count == 8 {
            showInvalidVehicleRegNumToast()
        }
        
        return string == "" || textField.text!.count < 8
    }
    
    private func showInvalidVehicleRegNumToast() {
        var toastStyle = ToastStyle()
        toastStyle.messageColor = .white
        view.makeToast("Vehicle registration number can't have more then 8 character.", position: .center, style: toastStyle)
    }
}
