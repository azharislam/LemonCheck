//
//  ClassName.swift
//  LemonCheck
//
//  Created by Az on 21/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import Foundation
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}
