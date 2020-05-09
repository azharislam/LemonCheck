//
//  Buttons.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

class Utilities {

    static func styleTextField(_ textfield:UITextField) {

        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)

        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1).cgColor

        // Remove border on text field
        textfield.borderStyle = .none

        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)

    }

    static func styleFilledButton(_ button:UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }

    static func styleSmallFilledButton(_ button:UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }

    static func styleHollowButton(_ button:UIButton) {

        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}
