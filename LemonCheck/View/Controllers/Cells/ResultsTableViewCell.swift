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
    @IBOutlet weak var bgView: UIView!
    
    var isOn: Bool = false
    
    override func layoutSubviews() {
        //if isOn
        //show green border
        //show Checkmark icon
        //else show yellow arrow
        //yellow border
        super.layoutSubviews()
        self.bgView.layer.cornerRadius = 18
        self.bgView.layer.borderWidth = 2

        if !isOn {
            self.bgView.layer.borderColor = UIColor.green.cgColor
            //icon is yellow arrow
        } else {
            self.bgView.layer.borderColor = UIColor.systemYellow.cgColor
            self.icon.image = UIImage(named: "rightArrow")
            //icon is green check
        }
        
    }
}
