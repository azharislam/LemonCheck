//
//  SignInWithAppleManager.swift
//  LemonCheck
//
//  Created by Biz Karimi on 25/10/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import AuthenticationServices

struct SignInWithAppleManager {
    
    static let userIdentifierKey = "userIdentifier"
    
    static func checkUserAuth(completion: @escaping (AuthState) -> ()) {
        guard let userIdentifier = UserDefaults.standard.string(forKey: userIdentifierKey) else {
            print("User identifier does not exist")
            completion(.undefined)
            return
        }
        if userIdentifier == "" {
            print("User identifier is empty string")
            completion(.undefined)
            return
        }
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid. Show Home UI Here
                    print("Credential state: .authorized")
                    completion(.signedIn)
                    break
                case .revoked:
                    // The Apple ID credential is revoked. Show SignIn UI Here.
                    print("Credential state: .revoked")
                    completion(.undefined)
                    break
                case .notFound:
                    // No credential was found. Show SignIn UI Here.
                    print("Credential state: .notFound")
                    completion(.signedOut)
                    break
                default:
                    break
                }
            }
        }
    }
    
}
