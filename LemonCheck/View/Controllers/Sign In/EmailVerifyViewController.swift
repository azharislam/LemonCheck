//
//  EmailVerifyViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 17/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EmailVerifyViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var verifyInfoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activateLabel: UILabel!


    override func viewDidLoad() {
        setUpElements()
        setUpNavigation()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func resendTapped(_ sender: Any) {
        sendVerificationMail()
        print("resend tapped")
    }

    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = true
        backButton.setImage(UIImage(named: Constants.Media.back), for: .normal)
        backButton.tintColor = .darkGray
    }

    private func setUpElements() {
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        Utilities.styleFilledButton(loginButton)
        Utilities.stylePasswordButton(resendButton)
        Utilities.formatBoldTitle(verifyInfoLabel, "An email has been sent to")
        Utilities.formatEmailTitle(emailLabel, userEmail)
        Utilities.formatBoldTitle(activateLabel, "Please click the link to verify your email.")
        Utilities.formatTitle(titleLabel)
        self.view.addBackground()
        self.verifyImage.image = UIImage(named: "verifyEmail1")
    }

    public func sendVerificationMail() {
        let authUser = Auth.auth().currentUser
        guard let isVerified = authUser?.isEmailVerified else { return }

        if authUser != nil && !isVerified {
            authUser?.sendEmailVerification(completion: { (error) in
                print("Verification successfully sent to new user")
            })
        }
        else {
            print("Error sending verification link")
        }
    }
    

}
