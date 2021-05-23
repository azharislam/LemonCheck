//
//  VehicleDataModel.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation

struct Vehicle: Codable {
    let response : Response?

    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}

struct Response : Codable {
    let dataItems : DataItems?

    enum CodingKeys: String, CodingKey {
        case dataItems = "DataItems"
    }
}
struct DataItems : Codable {
    let vrm: String?
    let make : String?
    let model : String?
    let year: String?
    let colour: String?
    let previousKeeperCount : Int?
    let writtenOff : Bool?
    let writeOffCategory : String?
    let writeOffDate : String?
    let financeRecordCount : Int?
    let financeRecordList : [String]?
    let stolen : Bool?
    let stolenInfoSource : String?
    let scrapped : Bool?
    let scrapDate : String?
    let imported : Bool?
    let importDate : String?

    enum CodingKeys: String, CodingKey {
        case vrm = "Vrm"
        case make = "Make"
        case model = "Model"
        case year = "YearOfManufacture"
        case colour = "Colour"
        case previousKeeperCount = "PreviousKeeperCount"
        case writtenOff = "WrittenOff"
        case writeOffCategory = "WriteOffCategory"
        case writeOffDate = "WriteOffDate"
        case financeRecordCount = "FinanceRecordCount"
        case financeRecordList = "FinanceRecordList"
        case stolen = "Stolen"
        case stolenInfoSource = "StolenInfoSource"
        case scrapped = "Scrapped"
        case scrapDate = "ScrapDate"
        case imported = "Imported"
        case importDate = "ImportDate"
    }
}

extension Vehicle {
    
    var make: String {
        return "\(response?.dataItems?.make ?? "")"
    }
    
    var model: String {
        return "\(response?.dataItems?.model ?? "")"
    }
    
    var vrm: String {
        return "\(response?.dataItems?.vrm ?? "")"
    }
    
    var year: String {
        return "\(response?.dataItems?.year ?? "")"
    }
    
    var previousKeeperCount: String {
        return "\(response?.dataItems?.previousKeeperCount ?? 0)"
    }
    
    var isWrittenOff: Bool {
        return response?.dataItems?.writtenOff ?? false
    }
    
    var isScrapped: Bool {
        return response?.dataItems?.scrapped ?? false
    }
    
    var isStolen: Bool {
        return response?.dataItems?.stolen ?? false
    }
    
    var isImported: Bool {
        return response?.dataItems?.imported ?? false
    }
    
    var isFinanced: Bool {
        if let financeList = financeRecordList {
            if !financeList.isEmpty {
                return true
            }
        }
        return false
    }
    
    var financeRecordCount: String {
        return "\(response?.dataItems?.financeRecordCount ?? 0)"
    }
    
    var financeRecordList: [String]? {
        return response?.dataItems?.financeRecordList ?? [""]
    }
    
    var writeOffDate: String {
        return "\(response?.dataItems?.writeOffDate ?? "")"
    }
    
    var stolenInfoSource: String {
        return "\(response?.dataItems?.stolenInfoSource ?? "")"
    }
    
    var importDate: String {
        return "\(response?.dataItems?.importDate ?? "")"
    }
    
    var scrapDate: String {
        return "\(response?.dataItems?.scrapDate ?? "")"
    }
    
    var writeOffCategory: String {
        return "\(response?.dataItems?.writeOffCategory ?? "")"
    }
    
    var totalCells: Int {
        var cells = 5
        if isWrittenOff {cells += 2}
        if isFinanced {cells += 1}
        if isImported {cells += 1}
        if isStolen {cells += 1}
        if isScrapped {cells += 1}
        return cells
    }
}
