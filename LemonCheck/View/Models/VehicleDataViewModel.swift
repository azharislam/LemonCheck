//
//  VehicleDataViewModel.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation

struct VdiViewModel {
    private let dataModel: Vehicle
    init(model: Vehicle) {
        self.dataModel = model
    }
}

extension VdiViewModel {
    
    var make: String {
        return "\(dataModel.response?.dataItems?.make ?? "")"
    }
    
    var model: String {
        return "\(dataModel.response?.dataItems?.model ?? "")"
    }
    
    var vrm: String {
        return "\(dataModel.response?.dataItems?.vrm ?? "")"
    }
    
    var year: String {
        return "\(dataModel.response?.dataItems?.year ?? "")"
    }
    
    var previousKeeperCount: String {
        return "\(dataModel.response?.dataItems?.previousKeeperCount ?? 0)"
    }
    
    var isWrittenOff: Bool {
        return dataModel.response?.dataItems?.writtenOff ?? false
    }
    
    var isScrapped: Bool {
        return dataModel.response?.dataItems?.scrapped ?? false
    }
    
    var isStolen: Bool {
        return dataModel.response?.dataItems?.stolen ?? false
    }
    
    var isImported: Bool {
        return dataModel.response?.dataItems?.imported ?? false
    }
    
    var financeRecordCount: String {
        return "\(dataModel.response?.dataItems?.financeRecordCount ?? 0)"
    }
    
    var financeRecordList: [String]? {
        return dataModel.response?.dataItems?.financeRecordList ?? [""]
    }
    
    var writeOffDate: String {
        return "\(dataModel.response?.dataItems?.writeOffDate ?? "")"
    }
    
    var stolenInfoSource: String {
        return "\(dataModel.response?.dataItems?.stolenInfoSource ?? "")"
    }
    
    var importDate: String {
        return "\(dataModel.response?.dataItems?.importDate ?? "")"
    }
    
    var scrapDate: String {
        return "\(dataModel.response?.dataItems?.scrapDate ?? "")"
    }
    
    var writeOffCategory: String {
        return "\(dataModel.response?.dataItems?.writeOffCategory ?? "")"
    }
}

//struct VdiViewModel {
//    private let searchDate: String?
//    private let vrm: String?
//    private let make : String?
//    private let model : String?
//    private let yearOfManufacture: String?
//    private let previousKeeperCount : Int?
//    private let writtenOff : Bool?
//    private let writeOffCategory : String?
//    private let writeOffDate : String?
//    private let financeRecordCount : Int?
//    private let financeRecordList : [String]?
//    private let stolen : Bool?
//    private let stolenInfoSource : String?
//    private let scrapped : Bool?
//    private let scrapDate : String?
//    private let imported : Bool?
//    private let importedDate : String?
//
//    init(dataModel: Vehicle) {
//        self.searchDate = Date().description
//        self.vrm = dataModel.response?.dataItems?.vrm
//        self.make = dataModel.response?.dataItems?.make
//        self.model = dataModel.response?.dataItems?.model
//        self.yearOfManufacture = dataModel.response?.dataItems?.yearOfManufacture
//        self.previousKeeperCount = dataModel.response?.dataItems?.previousKeeperCount
//        self.writtenOff = dataModel.response?.dataItems?.writtenOff
//        self.writeOffCategory = dataModel.response?.dataItems?.writeOffCategory
//        self.writeOffDate = dataModel.response?.dataItems?.writeOffDate
//        self.financeRecordCount = dataModel.response?.dataItems?.financeRecordCount
//        self.financeRecordList = dataModel.response?.dataItems?.financeRecordList
//        self.stolen = dataModel.response?.dataItems?.stolen
//        self.stolenInfoSource = dataModel.response?.dataItems?.stolenInfoSource
//        self.scrapped = dataModel.response?.dataItems?.scrapped
//        self.scrapDate = dataModel.response?.dataItems?.scrapDate
//        self.imported = dataModel.response?.dataItems?.imported
//        self.importedDate = dataModel.response?.dataItems?.importDate
//    }
//}

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

