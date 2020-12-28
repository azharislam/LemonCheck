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
    let dataElements = [
        "Make",
        "Model",
        "Year Of Manufacture",
        "Previous Keeper Count",
        "Written Off?",
        "Write Off Category",
        "Write Off Date",
        "Finance Record Count",
        "Finance Record List",
        "Stolen?",
        "Stolen Info Source",
        "Scrapped",
        "Scrap Date",
        "Imported?",
        "Import Date"]


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
        return dataElements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultTable.dequeueReusableCell(withIdentifier: "ResultCell") as? ResultsTableViewCell else { return UITableViewCell()}
        cell.resultLabel.text = dataElements[indexPath.row]
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.resultCircle.layer.cornerRadius = cell.resultCircle.frame.height / 2
        return cell
    }
}
