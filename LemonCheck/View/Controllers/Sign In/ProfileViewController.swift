//
//  ProfileViewController.swift
//  LemonCheck
//
//  Created by Biz Karimi on 25/10/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "User identifier: "
        
//        view.addSubview(stackView)
//        stackView.addArrangedSubview(label)
//        stackView.addArrangedSubview(UIView())
//        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SignInWithAppleManager.checkUserAuth { (authState) in
            switch authState {
            case .undefined:
                print("Signed undefined")
                let controller = LoginViewController()
                controller.modalPresentationStyle = .fullScreen
                controller.delegate = self
                self.present(controller, animated: true, completion: nil)
            case .signedOut:
                print("Signed out")
                let controller = LoginViewController()
                controller.modalPresentationStyle = .fullScreen
                controller.delegate = self
                self.present(controller, animated: true, completion: nil)
            case .signedIn:
                print("Signed in")
                print("User identifier: \(UserDefaults.standard.string(forKey: SignInWithAppleManager.userIdentifierKey)!)")
            }
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

}

extension ProfileViewController: LoginViewControllerDelegate {
    func didFinishAuth() {
        //label.text = "User identifier: \(UserDefaults.standard.string(forKey: SignInWithAppleManager.userIdentifierKey)!)"
        label.text = "User identifier: \(UserDefaults.standard.string(forKey: SignInWithAppleManager.userIdentifierKey)!)"
    }
}
