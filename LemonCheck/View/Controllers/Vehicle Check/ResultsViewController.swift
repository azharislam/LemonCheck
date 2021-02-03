//  ResultsViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

enum ResultData: Int {
    case make
    case model
    case year
    
    case Phone
    init?(indexPath: NSIndexPath) {
        self.init(rawValue: indexPath.section)
    }

    static var numberOfSections: Int { return 3 }
}


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
    
    
    private let service = LCNetworkRequest()
    var vehicle: Vehicle?
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
        resultTable.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        navigationItem.hidesBackButton = true
        print("\(vehicle)")
        resultTable.layer.cornerRadius = 18
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
//    func update(_ data: Vehicle) {
//        self.vehicle = data
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataElements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultTable.dequeueReusableCell(withIdentifier: "ResultCell") as? ResultsTableViewCell else { return UITableViewCell()}
        cell.label.text = dataElements[indexPath.row]
        if indexPath.row == 0 {
            if vehicle?.isWrittenOff == true {
                cell.isOn = true
            }
        }
        return cell
    }
}

//extension ResultsViewController: LCNetworkRequestDelegate {
//    func requestDidFinish(request: LCNetworkRequest, data: Vehicle) {
//        self.update(data)
//        self.resultTable.reloadData()
//    }
//
//    func requestDidFinish(request: LCNetworkRequest, error: APIResponseError) {
//        print(error.localizedDescription)
//    }
//
//}
