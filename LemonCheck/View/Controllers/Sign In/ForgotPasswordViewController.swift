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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpElements()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
        guard let email = resetEmailField.text, email != "" else {
            return print("Invalid email")
        }

        resetPassword(email: email)
    }

    private func popView() {
        navigationController?.popViewController(animated: true)
    }

    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = true
        backButton.setImage(UIImage(named: "return"), for: .normal)
        backButton.tintColor = .darkGray
    }

    private func setUpElements() {
        Utilities.styleTextField(resetEmailField)
        Utilities.styleFilledButton(resetPasswordButton)
        assignbackground()
    }

    private func assignbackground() {
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

    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: error.localizedDescription, preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                } else {
                    let resetEmailSentAlert = UIAlertController(title: "Reset Link Sent", message: "Check your email and follow instructions", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let loginVC = LoginViewController.instantiate() {
                        let rootViewController = UINavigationController(rootViewController: loginVC)
                        self.view.window?.rootViewController = rootViewController
                        self.view.window?.makeKeyAndVisible()
                        loginVC.present(resetEmailSentAlert, animated: true, completion: nil)
                    }
                }
            }
        })
    }

}
