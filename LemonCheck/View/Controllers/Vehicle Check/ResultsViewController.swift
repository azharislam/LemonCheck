//  ResultsViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultTable: UITableView!
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
        resultTable.delegate = self
        resultTable.dataSource = self
        navigationItem.hidesBackButton = true

//        let start = Date()
//        verifyCheckFor(vrm: VehicleInput.shared.reg!)
//        let end = Date()
//        print("Elapsed Time Results: \(end.timeIntervalSince(start))")
    }
}


//extension ResultsViewController: RegSearchDelegate {
//
//    func verifyCheckFor(vrm: String?) {
//        guard let userVrm = vrm else {
//            print("UNEXPECTEDLY RETURNED")
//            return
//        }
//
//        service.getFullVehicleDataFrom(regNumber: userVrm, completion: { [weak self] (response, error) in
//            guard let self = self else {return}
//            if let response = response {
//                let viewModel = VdiViewModel(dataModel: response)
////                self.displayVehicleInfo(using: viewModel)
//            } else {
//                print("Cannot find vehicle")
//            }
//        })
//    }
//}


extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
