//
//  UserData.swift
//  LemonCheck
//
//  Created by Azhar Islam on 17/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import AuthenticationServices

struct User {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
            ID: \(id)
            First Name: \(firstName)
            Last Name: \(lastName)
            Email: \(email)
            """
    }
}
