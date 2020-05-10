//
//  VehicleDataViewModel.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation

struct VdiViewModel {
    let searchDate: String?
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
    let importedDate : String?

    init(dataModel: Vehicle) {
        self.searchDate = Date().description
        self.vrm = dataModel.response?.dataItems?.vrm
        self.make = dataModel.response?.dataItems?.make
        self.model = dataModel.response?.dataItems?.model
        self.yearOfManufacture = dataModel.response?.dataItems?.yearOfManufacture
        self.previousKeeperCount = dataModel.response?.dataItems?.previousKeeperCount
        self.writtenOff = dataModel.response?.dataItems?.writtenOff
        self.writeOffCategory = dataModel.response?.dataItems?.writeOffCategory
        self.writeOffDate = dataModel.response?.dataItems?.writeOffDate
        self.financeRecordCount = dataModel.response?.dataItems?.financeRecordCount
        self.financeRecordList = dataModel.response?.dataItems?.financeRecordList
        self.stolen = dataModel.response?.dataItems?.stolen
        self.stolenInfoSource = dataModel.response?.dataItems?.stolenInfoSource
        self.scrapped = dataModel.response?.dataItems?.scrapped
        self.scrapDate = dataModel.response?.dataItems?.scrapDate
        self.imported = dataModel.response?.dataItems?.imported
        self.importedDate = dataModel.response?.dataItems?.importDate
    }
}

struct MotViewModel {
    let make : String?
    let model : String?
    let year: String?
    let colour: String?

    init(dataModel: MOTCheck) {
        self.make = dataModel.responseMOT?.dataItemsMOT?.vehicleDetails?.make
        self.model = dataModel.responseMOT?.dataItemsMOT?.vehicleDetails?.model
        self.year = dataModel.responseMOT?.dataItemsMOT?.vehicleDetails?.year
        self.colour = dataModel.responseMOT?.dataItemsMOT?.vehicleDetails?.colour
    }
}

