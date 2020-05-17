//
//  ForgotPasswordViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 12/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetEmailField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var forgotPwTitle: UILabel!
    @IBOutlet weak var forgotPwSubtitle: UILabel!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpElements()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
        guard let email = resetEmailField.text else { return }
        let error = validateField()

        if error != nil {
            guard let error = error else {return}
            showError(error)
        } else {
            self.resetPassword(email: email)
        }
    }

    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = true
        backButton.setImage(UIImage(named: Constants.Media.back), for: .normal)
        backButton.tintColor = .darkGray
    }

    private func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(resetEmailField)
        Utilities.styleFilledButton(resetPasswordButton)
        Utilities.formatBoldTitle(forgotPwTitle, Constants.UI.resetPwTitle)
        Utilities.formatBody(forgotPwSubtitle, Constants.UI.resetPwSubtitle)
        self.view.addBackground()
        self.hideKeyboardWhenTappedAround()
    }

    private func validateField() -> String? {
        if resetEmailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return Constants.Signup.resetEmail
        }
        return nil
    }

    func resetPassword(email: String) {
        if LoginViewController.instantiate() != nil {
            self.resetPasswordButton.loadingIndicator(show: true)
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                DispatchQueue.main.async {
                    if let error = error {
                        self.resetPasswordButton.loadingIndicator(show: false)
                        self.presentError(error)
                    } else {
                        self.resetPasswordButton.loadingIndicator(show: false)
                        self.navigationController?.popViewController(animated: true)
                        self.navigationController?.presentAlert(withTitle: Constants.Alert.resetLink, message: Constants.Alert.resetText)
                    }
                }
            })
        } else {
            print("Login View Controller is not in the frame")
        }
    }
}
