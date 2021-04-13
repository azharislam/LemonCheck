//
//  VerifyVehicleTableViewCell.swift
//  LemonCheck
//
//  Created by Azhar on 13/04/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class VerifyVehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(firstLabel: String, secondLabel: String?) {
        self.firstLabel.text = firstLabel
        self.secondLabel.text = secondLabel
    }
    
}
