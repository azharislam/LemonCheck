//
//  VerifyVehicleTableViewCell.swift
//  LemonCheck
//
//  Created by Azhar on 02/04/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class VerifyVehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(labelOne: String, labelTwo: String) {
        self.firstLabel.text = labelOne
        self.label.text = labelTwo
    }
}
