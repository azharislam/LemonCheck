//  ResultsViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    @IBOutlet weak var goToResultsButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var prevKeeperLabel: UILabel!
    @IBOutlet weak var writtenOffLabel: UILabel!
    @IBOutlet weak var writeOffDate: UILabel!
    @IBOutlet weak var financeRecordCountLabel: UILabel!
    @IBOutlet weak var financeRecordInfoLabel: UILabel!
    @IBOutlet weak var stolenLabel: UILabel!
    @IBOutlet weak var stolenInfoLabel: UILabel!
    @IBOutlet weak var regLabel: UILabel!
    @IBOutlet weak var firstRegisteredData: UILabel!
    @IBOutlet weak var importedData: UILabel!
    @IBOutlet weak var mileageAnomalyData: UILabel!
    
    
    private let service = RCNetworkRequest()
    private var vehicle: MOTCheck?
    private let transition = SlideTransition()


    override func viewDidLoad() {
        super.viewDidLoad()
        let start = Date()
        setUpView()
        verifyCheckFor(vrm: VehicleInput.shared.reg!)
        let end = Date()
        print("Elapsed Time Results: \(end.timeIntervalSince(start))")
    }
    
    
    func setUpView() {
        navigationItem.hidesBackButton = true
    }
    

    func displayVehicleInfo(using viewModel: VdiViewModel) {
        let motViewModel = MotViewModel(dataModel: vehicle!)
        let txtReg:String = VehicleInput.shared.reg!
        
        if(viewModel.make == nil) {
            print("Error, no data retrieved")
            return
        } else {
        regLabel?.text = txtReg
            makeLabel?.text = String("\(motViewModel.year!) \(motViewModel.colour!) \(viewModel.make!) \(motViewModel.model!)")
        prevKeeperLabel.text = String("\(viewModel.previousKeeperCount!)")
        importedData.text = viewModel.imported?.description

        
        if(viewModel.writtenOff == false) {
            //writtenOffLabel.textColor = UIColor.green
            writtenOffLabel.text = "No"
        } else {
            writtenOffLabel.text = "Yes"
        }
        
        
        if(viewModel.financeRecordList == []) {
            //financeRecordInfoLabel.textColor = UIColor.green
            financeRecordInfoLabel.text = "No"
        } else {
            financeRecordInfoLabel.text = "Yes"
        }
        

        if(viewModel.stolen == false) {
            //stolenLabel.textColor = UIColor.green
            stolenLabel.text = "No"
        } else {
            stolenLabel.text = "Yes"
        }
            
        
            if(viewModel.imported == false) {
            //stolenLabel.textColor = UIColor.green
            importedData.text = "No"
        } else {
            importedData.text = "Yes"
        }
            
        }
    }
}


extension ResultsViewController: RegSearchDelegate {
    
    func verifyCheckFor(vrm: String?) {
        guard let userVrm = vrm else {
            print("UNEXPECTEDLY RETURNED")
            return
        }
        
        service.getFullVehicleDataFrom(regNumber: userVrm, completion: { [weak self] (response, error) in
            guard let self = self else {return}
            if let response = response {
                let viewModel = VdiViewModel(dataModel: response)
                self.displayVehicleInfo(using: viewModel)
            } else {
                print("Cannot find vehicle")
            }
        })
    }
}


extension ResultsViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }

    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

