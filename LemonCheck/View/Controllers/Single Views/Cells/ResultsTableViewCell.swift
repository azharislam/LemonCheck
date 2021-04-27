//
//  ResultsTableViewCell.swift
//  LemonCheck
//
//  Created by Az on 03/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    var isGreen = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(label: String) {
        self.resultLabel.text = label
    }
}
