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

}
