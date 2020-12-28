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
    weak var delegate: RegSearchDelegate?
    let backgroundImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    
    func setView(){
        searchField.autocapitalizationType = .allCharacters
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "background")
    }
        

    @IBAction func searchPressed(_ sender: Any) {
        guard let userInput = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchFor(input: userInput)
    }

    
    func searchFor(input: String) {
        VehicleInput.shared.reg = input
        if input != "" {
            delegate?.verifyCheckFor(vrm: input)
            if let rgVC = VerifyVehicleViewController.instantiate() {
                //Push next screen
                self.navigationController?.pushViewController(rgVC, animated: true)
            }
        } else {
            print("Please enter a valid vehicle registration number")
        }
    }
}
