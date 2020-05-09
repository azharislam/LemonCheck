//
//  LoginViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func loginTapped(_ sender: Any) {
         signIn()
    }

    private func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(loginEmail)
        Utilities.styleTextField(loginPassword)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleSmallFilledButton(signupButton)
    }

    private func signIn() {
        let userEmail = textFrom(loginEmail)
        let userPassword = textFrom(loginPassword)
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
            if let error = error {
                self.errorLabel.text = error.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                self.transitionToHome()
            }
        }
    }

    private func transitionToHome() {
        if let homeVC = HomeViewController.instantiate() {
            let rootViewController = UINavigationController(rootViewController: homeVC)
            view.window?.rootViewController = rootViewController
            view.window?.makeKeyAndVisible()
        }
    }

    private func textFrom(_ text: UITextField) -> String {
        guard let fieldText = text.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return ""}
        return fieldText
    }

}
