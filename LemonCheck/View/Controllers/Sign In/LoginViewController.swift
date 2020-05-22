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
        let userEmail = textFrom(loginEmail)
        let userPassword = textFrom(loginPassword)
        self.loginButton.loadingIndicator(show: true)
        DispatchQueue.main.async {
            Auth.auth().currentUser?.reload(completion: { (error) in
                if error == nil {
                    Auth.auth().signIn(withEmail: userEmail, password: userPassword) { [weak self] (user, error) in
                        guard let self = self else {return}
                        if let error = error {
                            self.showError(error)
                            return
                        }
                    }

                    if Auth.auth().currentUser?.isEmailVerified == true {
                        self.loginButton.loadingIndicator(show: false)
                        self.transitionToHome()
                        print("User verified")
                    } else {
                        self.loginButton.loadingIndicator(show: false)
                        self.presentAlert(withTitle: "Verify Email", message: "Please verify your email first before logging in")
                        print("User not verified")
                    }
                }
            })
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
            homeVC.presentAlert(withTitle: "Success", message: "Welcome to Lemon Check")
        }
    }

    private func textFrom(_ text: UITextField) -> String {
        guard let fieldText = text.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return ""}
        return fieldText
    }

}
