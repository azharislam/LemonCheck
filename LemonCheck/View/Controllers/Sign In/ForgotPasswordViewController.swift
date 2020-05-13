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
            return //error
        }

        self.resetPassword(email: email, onSuccess: { [weak self] in
            guard let self = self else { return }
            self.view.endEditing(true)
            print("Password reset link sent to email")
            self.navigationController?.dismiss(animated: true, completion: nil)
        }) { (errorMessage) in
            print("Error sending reset email to user")
        }
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

    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                onSuccess()
            } else {
                guard let error = error else { return }
                onError(error.localizedDescription)
            }
        }
    }

}
