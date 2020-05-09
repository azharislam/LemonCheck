//
//  HomeViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

protocol RegSearchDelegate: NSObjectProtocol {
    func searchUserReg(vrm: String?)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    weak var delegate: RegSearchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
    }

    func setNavigationItems() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.view.backgroundColor = UIColor.white
    }

    @IBAction func searchPressed(_ sender: Any) {
        guard let userInput = searchField.text else { return }
        searchFor(input: userInput)
    }

    private func searchFor(input: String) {
        if input != "" {
            delegate?.searchUserReg(vrm: input)
            if let rgVC = ResultsViewController.instantiate() {
                self.delegate = rgVC
                rgVC.searchUserReg(vrm: input)
                self.navigationController?.pushViewController(rgVC, animated: true)
            }
        }
    }

}

