//
//  HomeViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var panel: UIView!
    private let service = LCNetworkRequest()
    
    weak var delegate: RegSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        searchButton.layer.cornerRadius = 8
        searchButton.layer.cornerRadius = 8
        panel.layer.cornerRadius = 18
        searchField.layer.borderWidth = 1
        searchField.layer.cornerRadius = 5
        searchField.layer.borderColor = UIColor.black.cgColor
        panel.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let userInput = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchFor(input: userInput)
    }
    
    private func searchFor(input: String) {
        VehicleInput.shared.reg = input
        if input != "" {
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
