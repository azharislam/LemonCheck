//
//  Int + Enum.swift
//  LemonCheck
//
//  Created by Az on 17/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

enum TableSection: Int {
    case writtenOff
    case financed
    case stolen
    case scrapped
    case imported
}

extension Int {
    var asTableSection: TableSection {
        if let section = TableSection(rawValue: self) {
            return section
        } else {
            return .imported
        }
    }
}
