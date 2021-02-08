//
//  VerifyPanelView.swift
//  LemonCheck
//
//  Created by Az on 08/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

@IBDesignable

class VerifyPanelView: UIView {
    
    @IBOutlet weak var vrmPlate: UIView!
    @IBOutlet weak var vrmLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "VerifyPanelView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
        self.layer.borderColor = UIColor.yellow.cgColor
        self.layer.borderWidth = 1
        vrmPlate.layer.cornerRadius = 12
        vrmPlate.layer.borderColor = UIColor.black.cgColor
        vrmPlate.layer.borderWidth = 1
    }
    
    func configureLabels(vrm: String?, make: String?, year: String?, colour: String?) {
        vrmLabel.text = vrm?.capitalized
        makeLabel.text = make
        yearLabel.text = year
        colourLabel.text = colour
    }
    
}
