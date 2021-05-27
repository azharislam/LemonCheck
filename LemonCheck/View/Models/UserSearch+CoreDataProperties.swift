//
//  UserSearch+CoreDataProperties.swift
//  LemonCheck
//
//  Created by Kazi Abdullah Al Mamun on 5/12/21.
//  Copyright © 2021 Varley Parker. All rights reserved.
//
//


import Foundation
import CoreData


extension UserSearch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSearch> {
        return NSFetchRequest<UserSearch>(entityName: "UserSearch")
    }

    @NSManaged public var colour: String?
    @NSManaged public var financeRecordCount: String?
    @NSManaged public var financeRecordList: [String]?
    @NSManaged public var importDate: String?
    @NSManaged public var isFinanced: Bool
    @NSManaged public var isImported: Bool
    @NSManaged public var isScrapped: Bool
    @NSManaged public var isWrittenOff: Bool
    @NSManaged public var make: String?
    @NSManaged public var model: String?
    @NSManaged public var previousKeeperCount: String?
    @NSManaged public var scrapDate: String?
    @NSManaged public var stolenInfoSource: String?
    @NSManaged public var vrm: String?
    @NSManaged public var writeOffCategory: String?
    @NSManaged public var writeOffDate: String?
    @NSManaged public var year: String?

}

extension UserSearch : Identifiable {

    func getVehicleModel() -> Vehicle {
        
        let dataItems = DataItems(vrm: vrm, make: make, model: model, year: year, colour: colour, previousKeeperCount: Int(previousKeeperCount ?? ""), writtenOff: isWrittenOff, writeOffCategory: writeOffCategory, writeOffDate: writeOffDate, financeRecordCount: Int(financeRecordCount ?? ""), financeRecordList: financeRecordList, stolen: (stolenInfoSource != nil && !stolenInfoSource!.isEmpty) ? true : false, stolenInfoSource: stolenInfoSource, scrapped: isScrapped, scrapDate: scrapDate, imported: isImported, importDate: importDate)
        let response = Response(dataItems: dataItems)
        return Vehicle(response: response)
    }
}
