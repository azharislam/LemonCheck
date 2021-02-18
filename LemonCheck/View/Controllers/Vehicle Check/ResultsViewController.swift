//  ResultsViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

enum ResultData: Int {
    case writtenOff
    case financed
    case stolen
    case scrapped
    case imported
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
        "Written Off?",
        "Financed?",
        "Scrapped?",
        "Stolen?",
        "Imported?"
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        resultTable.delegate = self
        resultTable.dataSource = self
        resultTable.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        navigationItem.hidesBackButton = true
        resultTable.layer.cornerRadius = 18
        resultTable.separatorStyle = .none
        resultTable.backgroundColor = .none
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataElements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultTable.dequeueReusableCell(withIdentifier: "ResultCell") as? ResultsTableViewCell else { return UITableViewCell()}
        cell.label.text = dataElements[indexPath.row]
        
        switch indexPath.row.asTableSection {
        case .writtenOff:
            if vehicle?.isWrittenOff == true {
                cell.isOn = true
            }
        case .financed:
            if vehicle?.isFinanced == true {
                cell.isOn = true
            }
        case .scrapped:
            if vehicle?.isScrapped == true {
                cell.isOn = true
            }
        case .stolen:
            if vehicle?.isStolen == true {
                cell.isOn = true
            }
        case .imported:
            if vehicle?.isImported == true {
                cell.isOn = true
            }
        }
        return cell
    }
}
