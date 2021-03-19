//
//  ResultSectionsModel.swift
//  LemonCheck
//
//  Created by Azhar on 19/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

struct ResultSections {
    var headerName: String?
    var subResults = [String]()
    var expandable: Bool? = false
    
    init(headerName: String, subResults: [String], expandable: Bool) {
        self.headerName = headerName
        self.subResults = subResults
        self.expandable = expandable
    }
}
