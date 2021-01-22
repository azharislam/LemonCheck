//
//  MainViewController.swift
//  SIWA UIKit
//
//  Created by Kyle Lee on 6/13/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var detailzLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailzLabel.text = user?.debugDescription ?? "nothing here"
    }
}
