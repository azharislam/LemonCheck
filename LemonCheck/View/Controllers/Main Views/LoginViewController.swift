//
//  LoginViewController.swift
//  LemonCheck
//
//  Created by Azhar on 13/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import AuthenticationServices
import UIKit
import CloudKit

class LoginViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([
            appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    @objc
    func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? HomeViewController, let user = sender as? User {
            mainVC.user = user
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        let privateDatabase = CKContainer(identifier: "iCloud.LemonCheck").privateCloudDatabase

        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let userId = credentials.user
            
            // Record first name, last name and email
            
            if let name = credentials.fullName?.givenName,
               let email = credentials.email {
                
                // New user (signing up)
                // Save info to CloudKit
                
                let record = CKRecord(recordType: "userInfo", recordID: CKRecord.ID(recordName: userId))
                record["name"] = name
                record["email"] = email
                privateDatabase.save(record) { (_,_) in
                    UserDefaults.standard.set(record.recordID.recordName, forKey: "userProfileID")
                    print("User has been SAVED INTO DATABASE")
                }
                
                
            } else {
                
                // Returning user (signing in)
                // Fetch user name and email
                // From private CloudKit
                privateDatabase.fetch(withRecordID: CKRecord.ID(recordName: userId)) { (record, error) in
                    if let fetchedInfo = record {
                        let name = fetchedInfo["name"] as? String
                        let userEmail = fetchedInfo["email"] as? String
                        print("User already has account")
                        // Set this info in Settings view controller
                        
                        UserDefaults.standard.set(userId, forKey: "userProfileID")
                    }
                }
                
            }
            
            UserDefaults.standard.set(true, forKey: "status")
            Switcher.updateRootVC()
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error logging in", error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}
