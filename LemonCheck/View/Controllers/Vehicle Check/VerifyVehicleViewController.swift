//
//  VerifyVehicleViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 09/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

class VerifyVehicleViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var goToResultsButton: UIButton!
    
    private let service = RCNetworkRequest()
    private var vehicle: MOTCheck?


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayVehicleInfo(using viewModel: MotViewModel) {
        makeLabel?.text = viewModel.make
        modelLabel?.text = viewModel.model
        yearLabel.text = viewModel.year
        colourLabel.text = viewModel.colour
    }

}

extension VerifyVehicleViewController: RegSearchDelegate {
    func verifyCheckFor(vrm: String?) {
        guard let userVrm = vrm else { return }
        service.getInitialVehicleData(regNumber: userVrm, completion: { [weak self] (response, error) in
            guard let self = self else {return}
            if let response = response {
                let viewModel = MotViewModel(dataModel: response)
                self.displayVehicleInfo(using: viewModel)
            } else {
                print("Cannot find vehicle")
            }
        })
    }

    func getFullCheck(vrm: String?) {
        //
    }
}
