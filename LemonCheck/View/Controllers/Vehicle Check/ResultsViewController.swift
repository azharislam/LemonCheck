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
    @IBOutlet weak var vehicleInfoPanel: VerifyPanelView!
    
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
        resultTable.backgroundColor = .clear
        configureView()
    }
    
    private func configureView() {
        vehicleInfoPanel.layer.cornerRadius = 18
        vehicleInfoPanel.makeLabel.text = vehicle?.make
        vehicleInfoPanel.vrmLabel.text = vehicle?.vrm
        vehicleInfoPanel.colourLabel.text = vehicle?.model
        vehicleInfoPanel.yearLabel.text = vehicle?.year
        vehicleInfoPanel.layer.backgroundColor = UIColor.white.cgColor
        vehicleInfoPanel.vrmPlate.backgroundColor = .yellow
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
