//
//  ResultHeaderView.swift
//  LemonCheck
//
//  Created by Azhar on 19/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class ResultHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        button.backgroundColor = .systemYellow
        button.titleLabel?.textColor = UIColor.black
        button.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        return button
    }()

    @objc func onClickHeaderView() {
        print("headerview tapped")
    }
}
