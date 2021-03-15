//
//  OrderTableViewCell.swift
//  LemonCheck
//
//  Created by Azhar on 15/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberPlateView: NumberPlateView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureViews()
    }
    
    private func configureViews() {
        numberPlateView.layer.cornerRadius = 8
        numberPlateView.backgroundColor = .yellow
    }
    
    func configureLabel(make: String, model: String) {
        self.makeLabel.text = make
        self.modelLabel.text = model
    }
}
