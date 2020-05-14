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

    // MARK: - Textfields

    static func styleTextField(_ textfield:UITextField) {

        // Text
        textfield.textColor = .black
        textfield.font = UIFont(name: "Avenir", size: 15)

        // Placeholder
        let color = UIColor.darkGray
        let placeholder = textfield.placeholder ?? ""
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        // Design
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)

    }

    static func passwordTextField(_ textfield:UITextField) {

        // Text
        textfield.textColor = .black //change to password text
        textfield.font = UIFont(name: "Avenir", size: 15)

        // Placeholder
        let color = UIColor.darkGray
        let placeholder = textfield.placeholder ?? ""
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        // Textfield
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }

    // MARK: - Buttons

    static func styleFilledButton(_ button:UIButton) {

        button.backgroundColor = UIColor.init(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.2
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir New", size: 20)
    }

    // MARK: - Labels

    static func formatTitle(_ button: UILabel) {
        //format header title
    }

    static func formatSubtitle(_ button: UILabel) {
        //format subtitle
    }
}
