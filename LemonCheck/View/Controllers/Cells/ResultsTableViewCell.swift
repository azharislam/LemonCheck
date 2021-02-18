//
//  ResultsTableViewCell.swift
//  LemonCheck
//
//  Created by Az on 03/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    var isOn: Bool = false
    
    override func layoutSubviews() {
        //if isOn
        //show green border
        //show Checkmark icon
        //else show yellow arrow
        //yellow border
        super.layoutSubviews()
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

        if !isOn {
            self.layer.borderColor = UIColor.yellow.cgColor
            //icon is yellow arrow
        } else {
            self.layer.borderColor = UIColor.green.cgColor
            //icon is green check
        }
        
    }
}
