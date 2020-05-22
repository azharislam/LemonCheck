//
//  UIAlertViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 17/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
