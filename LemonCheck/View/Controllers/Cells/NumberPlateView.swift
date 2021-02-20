//
//  NumberPlateView.swift
//  LemonCheck
//
//  Created by Az on 20/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit


@IBDesignable
class NumberPlateView: UIView {
    
    @IBOutlet weak var numberPlate: UIView!
    @IBOutlet weak var vrmLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    func configureView() {
        self.layoutSubviews()
        numberPlate.layer.cornerRadius = 12
        numberPlate.backgroundColor = .yellow
        vrmLabel.font = UIFont(name: "UKNumberPlate", size: 50)
    }
}
