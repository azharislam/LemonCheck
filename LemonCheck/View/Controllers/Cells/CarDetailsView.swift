//
//  CarDetailsView.swift
//  LemonCheck
//
//  Created by Az on 20/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class CarDetailsView: UIView {
    
    @IBOutlet weak var numberPlateView: NumberPlateView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var previousOwnerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "CarDetailsView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configurePanel(vrm: String, make: String, model: String, year: String, previousOwners: String) {
        self.numberPlateView.configureLabel(vrm: vrm)
        self.makeLabel.text = make
        self.modelLabel.text = model
        self.yearLabel.text = year
        self.previousOwnerLabel.text = previousOwners
    }
    
}
