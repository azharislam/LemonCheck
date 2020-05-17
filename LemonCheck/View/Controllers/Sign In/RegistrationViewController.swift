//
//  RegistrationViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var helloTitle: UILabel!
    @IBOutlet weak var helloSubtitle: UILabel!
    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        setUpNavigation()
        view.addBackground()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func signUpTapped(_ sender: Any) {

        // Validate fields
        let error = validateFields()

        if error != nil {
            showError(error!)
        } else {
            self.createUser(auth: Auth.auth())
        }
    }

    func createUser(auth: Auth) {
        self.signupButton.loadingIndicator(show: true)
        guard let fullNameField = firstNameField.text else {return}
        let fullName = Name(fullName: fullNameField)
        let firstName = fullName.first
        let lastName = fullName.last
        let email = textFrom(emailField)
        let password = textFrom(passwordField)
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {return}


        // Create user
        auth.createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                guard let error = err else { return }
                self.signupButton.loadingIndicator(show: false)
                self.presentError(error)
            } else {
                // Add user to database
                guard let createUser = result else { return }
                let db = Firestore.firestore()
                db.collection("users").addDocument(
                    data: ["firstName": firstName,
                           "lastName": lastName,
                           "userId": createUser.user.uid,
                           "deviceId": deviceId])
                {
                    (error) in
                    guard let error = error else {return}
                    self.presentError(error)
                }
                self.sendVerificationMail()
                self.transitionToHome()
                self.signupButton.loadingIndicator(show: false)
            }
        }
    }

    public func sendVerificationMail() {
        let authUser = Auth.auth().currentUser
        guard let isVerified = authUser?.isEmailVerified else { return }
        
        if authUser != nil && !isVerified {
            authUser?.sendEmailVerification(completion: { (error) in
                self.presentAlert(withTitle: "Success", message: "A verification link has been sent to your email")
                //transition to verification view
            })
        }
        else {
            print("Error sending verification link")
        }
    }

    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = true
        backButton.setImage(UIImage(named: Constants.Media.back), for: .normal)
        backButton.tintColor = .darkGray
    }

    private func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(signupButton)
        Utilities.formatTitle(helloTitle)
        Utilities.formatSubtitle(helloSubtitle)
        self.hideKeyboardWhenTappedAround()
    }

    private func textFrom(_ text: UITextField) -> String {
        guard let fieldText = text.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return ""}
        return fieldText
    }

    private func validateFields() -> String? {
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return Constants.Signup.fillInFields
        }

        if Validation.isPasswordValid(textFrom(passwordField)) == false {
            return Constants.Signup.passwordError
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
            homeVC.presentAlert(withTitle: "Success", message: "Your account has been successfully created")
        }
    }

    private func transitionToLogin() {
        if let homeVC = LoginViewController.instantiate() {
            let rootViewController = UINavigationController(rootViewController: homeVC)
            view.window?.rootViewController = rootViewController
            view.window?.makeKeyAndVisible()
        }
    }

}
