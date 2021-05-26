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

enum CarDetails: Int {
    case make
    case model
    case year
    case colour
    case ulez
    case prevOwners
}

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var numberPlateView: NumberPlateView!
    @IBOutlet weak var carDetailsTableView: UITableView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var resultTableHeightConstraint: NSLayoutConstraint!
    
    let resultIdentifier = "ResultCell"
    let detailsIdentifier = "VVCell"
    
    private let service = LCNetworkRequest()
    var vehicle: Vehicle?
    var colour: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        guard let vehicleDetails = vehicle else { return }
        resultTableHeightConstraint.constant = CGFloat(vehicleDetails.resultTblViewHeight())
        carDetailsTableView.delegate = self
        carDetailsTableView.dataSource = self
        carDetailsTableView.register(UINib(nibName: VerifyVehicleTableViewCell.className, bundle: nil), forCellReuseIdentifier: detailsIdentifier)
        resultTable.delegate = self
        resultTable.dataSource = self
        resultTable.register(UINib(nibName: ResultsTableViewCell.className, bundle: nil), forCellReuseIdentifier: resultIdentifier)
        numberPlateView.configureLabel(vrm: vehicleDetails.vrm)
    }
    
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == carDetailsTableView {
            return 6
        } else if tableView == resultTable {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == carDetailsTableView {
            return "VEHICLE INFO"
        } else {
            return "FULL CHECK"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if tableView == carDetailsTableView {
            label.text = "VEHICLE INFO"
            label.font = UIFont(name: "DMSans-Bold", size: 14)
            label.textColor = UIColor(named: "CharcoalGrey")
            label.backgroundColor = UIColor(named: "OffWhite")
        } else {
            label.text = "FULL CHECK"
            label.font = UIFont(name: "DMSans-Bold", size: 14)
            label.textColor = UIColor(named: "CharcoalGrey")
            label.backgroundColor = UIColor(named: "OffWhite")
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == carDetailsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: detailsIdentifier) as? VerifyVehicleTableViewCell else { return UITableViewCell()}
            let detailsSection = CarDetails(rawValue: indexPath.row)
            switch detailsSection {
            case .make:
                cell.configure(firstLabel: "Make", secondLabel: vehicle?.make ?? "")
            case .model:
                cell.configure(firstLabel: "Model", secondLabel: vehicle?.model ?? "")
            case .colour:
                cell.configure(firstLabel: "Colour", secondLabel: colour ?? "")
            case .year:
                cell.configure(firstLabel: "Year", secondLabel: vehicle?.year ?? "")
            case .ulez:
                cell.configure(firstLabel: "ULEZ Compliant", secondLabel: "Yes")
            case .prevOwners:
                cell.configure(firstLabel: "Previous Owners", secondLabel: vehicle?.previousKeeperCount ?? "")
            case .none:
                break
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: resultIdentifier) as? ResultsTableViewCell else { return UITableViewCell() }
            let resultSection = ResultData(rawValue: indexPath.row)
            switch resultSection {
            case .writtenOff:
                if vehicle?.isWrittenOff ?? false {
                    cell.isGreen = false
                    var subDatas = [(String, String)]()
                    
                    if let writeOffDate = vehicle?.writeOffDate, !writeOffDate.isEmpty {
                        subDatas.append(("Write Off Date", writeOffDate))
                    }
                    
                    if let writeOffCategory = vehicle?.writeOffCategory, !writeOffCategory.isEmpty {
                        subDatas.append(("Write Off Category", writeOffCategory))
                    }
                    
                    cell.configure(label: "Written Off", subDatas: subDatas)
                } else {
                    cell.isGreen = true
                    cell.configure(label: "No Written Off")
                }
            case .financed:
                if vehicle?.isFinanced ?? false {
                    cell.isGreen = false
                    var subDatas = [String]()
                    
                    if let financedRecordList = vehicle?.financeRecordList {
                        subDatas = financedRecordList
                    }
                    cell.configure(label: "Financed", subFinanceDatas: subDatas)
                } else {
                    cell.isGreen = true
                    cell.configure(label: "No Financed")
                }
            case .imported:
                if vehicle?.isImported ?? false {
                    cell.isGreen = false
                    var subDatas = [(String, String)]()
                    
                    if let importDate = vehicle?.importDate, !importDate.isEmpty {
                        subDatas.append(("Import Date", importDate))
                    }
                    cell.configure(label: "Imported", subDatas: subDatas)
                } else {
                    cell.isGreen = true
                    cell.configure(label: "No Imported")
                }
            case .scrapped:
                if vehicle?.isScrapped ?? false {
                    cell.isGreen = false
                    var subDatas = [(String, String)]()
                    
                    if let scrapDate = vehicle?.scrapDate, !scrapDate.isEmpty {
                        subDatas.append(("Scrap Date", scrapDate))
                    }
                    cell.configure(label: "Scrapped", subDatas: subDatas)
                } else {
                    cell.isGreen = true
                    cell.configure(label: "No Scrapped")
                }
            case .stolen:
                if vehicle?.isStolen ?? false {
                    cell.isGreen = false
                    var subDatas = [(String, String)]()
                    
                    if let stolenInfoSource = vehicle?.stolenInfoSource, !stolenInfoSource.isEmpty {
                        subDatas.append(("Stolen Info Source", stolenInfoSource))
                    }
                    cell.configure(label: "Stolen")
                } else {
                    cell.isGreen = true
                    cell.configure(label: "No Stolen")
                }
            case .none:
                break
            }
            return cell
        }
    }
}
