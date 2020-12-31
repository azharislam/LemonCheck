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
        //controller.delegate = self
        //controller.presentationContextProvider = self
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
