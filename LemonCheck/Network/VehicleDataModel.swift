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
    let yearOfManufacture: String?
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
        case yearOfManufacture = "YearOfManufacture"
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
