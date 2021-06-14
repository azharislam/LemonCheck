//
//  OrderTableViewCell.swift
//  LemonCheck
//
//  Created by Azhar on 15/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var numberPlate: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureLabel(make: String, model: String, vim: String, date: String) {
        self.makeLabel.text = "\(make) \(model)"
        self.numberPlate.text = vim
        self.orderDate.text = date
    }
}
