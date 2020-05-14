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
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = true
        backButton.setImage(UIImage(named: "return"), for: .normal)
        backButton.tintColor = .darkGray
    }


    private func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(signupButton)
        assignbackground()
    }

    private func validateFields() -> String? {

        // Check that all fields are filled in
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
            self.createUser(auth: Auth.auth())
            self.sendConfirmationEmail()
            self.transitionToHome()
        }
    }

    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    // Add background image
    func assignbackground(){
        let background = UIImage(named: "background")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
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
                db.collection("users").addDocument(data: ["firstName": firstName, "userId": createUser.user.uid, "deviceId": deviceId]) { (error) in
                    guard let error = error else {return}
                    self.showError(error.localizedDescription)
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
