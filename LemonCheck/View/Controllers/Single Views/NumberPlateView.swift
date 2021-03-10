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
        guard let view = self.loadViewFromNib(nibName: NumberPlateView.className) else {return}
        view.frame = self.bounds
        self.addSubview(view)
        numberPlate.layer.cornerRadius = 12
        numberPlate.backgroundColor = .yellow
        numberPlate.layer.borderWidth = 1
        numberPlate.layer.borderColor = UIColor.black.cgColor
        vrmLabel.font = UIFont(name: Constants.Fonts.ukNumberPlate, size: 32)
    }
    
    func configureLabel(vrm: String) {
        self.vrmLabel.text = vrm
    }
}
