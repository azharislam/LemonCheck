//
//  ResultsViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ResultsViewController: UIViewController {

    private let transition = SlideTransition()
    private let service = RCNetworkRequest()

    private var database = Database.database().reference()
    private var vehicle: Vehicle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismiss(animated: true)
    }

    func setNavigationItems() {
            let navigationBar = navigationController?.navigationBar
            navigationBar?.barTintColor = UIColor.white
            self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
            self.view.backgroundColor = UIColor.white
        }

    func displayVehicleInfo(using viewModel: VdiViewModel) {
//        userRegLabel?.text = viewModel.vrm
//        makeLabel?.text = viewModel.make
//        modelLabel?.text = viewModel.model
    }

    func searchReferenceId() -> String {
        let uuid = UUID().uuidString
        return "VRS" + uuid
    }


    func vehicleSearchResults(_ viewModel: VdiViewModel) -> [String: Any] {
        let results: [String: Any] = [
            "Reference" : searchReferenceId(),
            "Date" : Date().string(format: "yyyy-MM-dd"),
            "Vrm" : viewModel.vrm ?? "",
            "Make" : viewModel.make ?? "",
            "Model": viewModel.model ?? "",
            "YearOfManufacture" : viewModel.yearOfManufacture ?? "",
            "PreviousKeeperCount" : viewModel.previousKeeperCount ?? 0,
            "WrittenOff" : viewModel.writtenOff ?? false,
            "WriteOffCategory" : viewModel.writeOffCategory ?? "Not available",
            "WriteOffDate" : viewModel.writeOffDate ?? "",
            "FinanceRecordCount" : viewModel.financeRecordCount ?? 0,
            "FinanceRecordList" : viewModel.financeRecordList ?? [""],
            "Stolen" : viewModel.stolen ?? false,
            "StolenInfoSource" : viewModel.stolenInfoSource ?? "",
            "Scrapped" : viewModel.scrapped ?? false,
            "ScrapDate" : viewModel.scrapDate ?? "",
            "Imported" : viewModel.imported ?? false,
            "ImportDate" : viewModel.importedDate ?? ""
        ]

        return results
    }

}

extension ResultsViewController: RegSearchDelegate {
    func verifyCheckFor(vrm: String?) {
        //
    }

    func getFullCheck(vrm: String?) {
        guard let authUser = Auth.auth().currentUser, let userVrm = vrm else { return }

        let currentDate = Date().description

        service.getFullVehicleDataFrom(regNumber: userVrm) {[weak self] (response, error) in
            guard let self = self else {return}
            if let response = response {
                let viewModel = VdiViewModel(dataModel: response)
                self.displayVehicleInfo(using: viewModel)
                self.database.child("customer").child("id").child(authUser.uid).child("vrmSearch").child(currentDate).setValue(self.vehicleSearchResults(viewModel))
            }
        }
    }
}
