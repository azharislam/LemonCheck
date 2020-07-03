//
//  HomeViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

protocol RegSearchDelegate: NSObjectProtocol {
    func verifyCheckFor(vrm: String?)
    func getFullCheck(vrm: String?)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!

    
    private let transition = SlideTransition()
    weak var delegate: RegSearchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        Utilities.styleSearchField(searchField)
        setNavigationItems()
    }

    @IBAction func menuButtonTapped(_ sender: Any) {
        if let menuVc = MenuViewController.instantiate() {
            menuVc.modalPresentationStyle = .overCurrentContext
            menuVc.transitioningDelegate = self
            present(menuVc, animated: true)
        }
    }
    

    func setNavigationItems() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.view.backgroundColor = UIColor.white
        self.view.addMainBackground()
        self.logoImage.image = UIImage(named: "logoImage")
    }

    @IBAction func searchPressed(_ sender: Any) {
        guard let userInput = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchFor(input: userInput)
    }

    private func searchFor(input: String) {
        if input != "" {
            delegate?.verifyCheckFor(vrm: input)
            if let rgVC = VerifyVehicleViewController.instantiate() {
                self.delegate = rgVC
                rgVC.verifyCheckFor(vrm: input)
                self.navigationController?.pushViewController(rgVC, animated: true)
            }
        } else {
            print("Please enter a valid vehicle registration number")
        }
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }

}

extension HomeViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length

        return newLength <= 8
    }
}
