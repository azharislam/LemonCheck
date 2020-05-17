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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forgottenPassword: UIButton!
    @IBOutlet weak var helloTitle: UILabel!
    @IBOutlet weak var helloSubtitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        setUpNavigation()
    }

    @IBAction func loginTapped(_ sender: Any) {
        let error = validateFields()

        if error != nil {
            showError(error!)
        } else {
            signIn()
        }
    }

    @IBAction func forgotPasswordTapped(_ sender: Any) {
        if let forgotVC = ForgotPasswordViewController.instantiate() {
            self.navigationController?.pushViewController(forgotVC, animated: true)
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = true
        backButton.setImage(UIImage(named: Constants.Media.back), for: .normal)
        backButton.tintColor = .darkGray
    }

    private func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(loginEmail)
        Utilities.styleTextField(loginPassword)
        Utilities.styleFilledButton(loginButton)
        Utilities.stylePasswordButton(forgottenPassword)
        Utilities.formatTitle(helloTitle)
        Utilities.formatSubtitle(helloSubtitle)
        self.view.addBackground()
        self.hideKeyboardWhenTappedAround()
    }

    private func signIn() {
        self.loginButton.loadingIndicator(show: true)
        let userEmail = textFrom(loginEmail)
        let userPassword = textFrom(loginPassword)
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, error) in
            if let error = error {
                self.loginButton.loadingIndicator(show: false)
                self.showError(error)
            } else {
                self.loginButton.loadingIndicator(show: false)
                self.transitionToHome()
            }
        }
    }

    private func validateFields() -> String? {
        if loginEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            loginPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return Constants.Signup.fillInFields
        }

        return nil
    }

    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }


    private func transitionToHome() {
        if let homeVC = HomeViewController.instantiate() {
            let rootViewController = UINavigationController(rootViewController: homeVC)
            view.window?.rootViewController = rootViewController
            view.window?.makeKeyAndVisible()
            homeVC.presentAlert(withTitle: "Welcome Back", message: "Login successful")
        }
    }

    private func textFrom(_ text: UITextField) -> String {
        guard let fieldText = text.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return ""}
        return fieldText
    }

}
