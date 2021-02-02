//
//  ResultsTableViewCell.swift
//  LemonCheck
//
//  Created by Az on 28/12/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var resultCircle: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    var isOn: Bool = false
    
    override func layoutSubviews() {
        if !isOn {
            resultCircle.backgroundColor = .green
        } else {
            resultCircle.backgroundColor = .red
        }
    }
    
}
