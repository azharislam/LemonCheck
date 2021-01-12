//
//  LoginViewController.swift
//  LemonCheck
//
//  Created by Biz Karimi on 25/10/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol LoginViewControllerDelegate {
    func didFinishAuth()
}

class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    
    lazy var appleLogInButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(appleLogInButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func appleLogInButtonTapped() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        //stackView.addArrangedSubview(UIView)
        stackView.addArrangedSubview(appleLogInButton)
        //stackView.addArrangedSubview(UIView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        appleLogInButton.translatesAutoresizingMaskIntoConstraints = false
        appleLogInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        appleLogInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        appleLogInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        appleLogInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
}

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential){
        print("Registering new account with user: \(credential.user)")
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential){
        print("Sign in with existing user: \(credential.user)")
        print("Their name is: \(credential.fullName!)")
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func signInWithUserAndPassword(credential: ASPasswordCredential){
        print("Signing in using an existing iCloud keychain credential: \(credential.user)")
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            
            let userId = appleIdCredential.user
            //let fullName = appleIdCredential.fullName
            UserDefaults.standard.set(userId, forKey: SignInWithAppleManager.userIdentifierKey)

            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                registerNewAccount(credential: appleIdCredential)
            } else {
                signInWithExistingAccount(credential: appleIdCredential)
            }
            
            break
            
        case let passwordCredential as ASPasswordCredential:
            let userId = passwordCredential.user
            UserDefaults.standard.set(userId, forKey: SignInWithAppleManager.userIdentifierKey)
            
            signInWithUserAndPassword(credential: passwordCredential)
            
            break
            
        default:
            break
            }
        }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    
}
