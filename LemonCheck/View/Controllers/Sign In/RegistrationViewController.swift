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
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.navigationBar.isHidden = true
    }

    private func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameField)
        Utilities.styleTextField(lastNameField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(signupButton)
        Utilities.styleSmallFilledButton(loginButton)
    }

    private func validateFields() -> String? {

        // Check that all fields are filled in
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }

        if Validation.isPasswordValid(textFrom(passwordField)) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }

        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {

        // Validate fields
        let error = validateFields()

        if error != nil {
            showError(error!)
        } else {
            self.sendConfirmationEmail()
            self.createUser(auth: Auth.auth())
        }
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
        }
    }

    func createUser(auth: Auth) {
        let firstName = textFrom(firstNameField)
        let lastName = textFrom(lastNameField)
        let email = textFrom(emailField)
        let password = textFrom(passwordField)
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {return}


        // Create user
        auth.createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.showError("Error creating user")
            } else {
                // Add user to database
                guard let createUser = result else { return }
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "userId": createUser.user.uid, "deviceId": deviceId]) { (error) in
                    self.showError("Error saving user data")
                }
            }
        }
    }

    private func sendConfirmationEmail() {

        guard let authUser = Auth.auth().currentUser else { return }

        // Here you check if user exist
        if authUser.isEmailVerified == false {
            authUser.sendEmailVerification(completion: { (error) in
                print("Email verification sent")
                self.transitionToHome()
            })
        }
        else {
              print("Waiting for user to be verified")
        }
    }

    private func textFrom(_ text: UITextField) -> String {
        guard let fieldText = text.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return ""}
        return fieldText
    }

}
