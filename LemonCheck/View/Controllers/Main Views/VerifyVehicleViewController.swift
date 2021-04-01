//
//  VerifyVehicleViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 09/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Foundation

protocol UpdateOrderHistoryDelegate {
    func updateTableView(finished: Bool)
}

class VerifyVehicleViewController: UIViewController {
    
    @IBOutlet weak var paymentPanel: PaymentPanelView!
    @IBOutlet weak var vehiclePanel: VerifyPanelView!
    @IBOutlet weak var questionStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var numberPlateView: NumberPlateView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ulezLabel: UILabel!
    
    var delegate: UpdateOrderHistoryDelegate?
    
    private let service = LCNetworkRequest()
    private var vehicle: MOTCheck?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var carMake: String?
    var carColour: String?
    var carYear: String?
    var vrm: String?
    var orders: [UserSearch]?
    
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
        // Make background view dark so panel stands out
        // Animate panel to come up
        paymentPanel.isHidden = false
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        paymentPanel.isHidden = true
        yesButton.layer.cornerRadius = 16
        noButton.layer.cornerRadius = 16
        self.numberPlateView.vrmLabel.text = self.vrm ?? ""
        self.configureEntities(make: self.carMake ?? "", year: self.carYear ?? "", color: self.carColour ?? "")
    }
    
    private func configureEntities(make: String, year: String, color: String) {
        self.makeLabel.text = make
        self.colorLabel.text = color
        self.yearLabel.text = year
    }
    
    private func saveUserSearch(response: Vehicle) {
        
        // Create UserSearch object and write results to data model
        let newUserSearch = UserSearch(context: self.context)
        newUserSearch.vrm = response.vrm
        newUserSearch.make = response.make
        newUserSearch.model = response.model
        newUserSearch.colour = self.carColour
        newUserSearch.year = response.year
        newUserSearch.isWrittenOff = response.isWrittenOff
        newUserSearch.isFinanced = response.isFinanced
        newUserSearch.isScrapped = response.isScrapped
        newUserSearch.isImported = response.isImported
        newUserSearch.financeRecordCount = response.financeRecordCount
        newUserSearch.financeRecordList = response.financeRecordList
        newUserSearch.importDate = response.importDate
        newUserSearch.writeOffDate = response.writeOffDate
        newUserSearch.writeOffCategory = response.writeOffCategory
        newUserSearch.scrapDate = response.scrapDate
        newUserSearch.previousKeeperCount = response.previousKeeperCount
        newUserSearch.stolenInfoSource = response.stolenInfoSource
        
        // Save the data
        do {
            try self.context.save()
        }
        catch {
            print("Error saving results to database")
        }
        
        self.delegate?.updateTableView(finished: true)
    }
    
    private func configureCallbacks() {
        paymentPanel.paymentCallback = {
            self.service.getFullVehicleDataFrom(regNumber: VehicleInput.shared.reg!) { [weak self] (response, error) in
                guard let self = self else {return}
                if let response = response {
                    
                    // Write and save data to CoreData
                    self.saveUserSearch(response: response)
    
                    // Push results view onto stack
                    if let rgVC = ResultsViewController.instantiate() {
                        self.navigationController?.pushViewController(rgVC, animated: true)
                        
                        // Assign response from call to the Vehicle instance in ResultsVC
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
