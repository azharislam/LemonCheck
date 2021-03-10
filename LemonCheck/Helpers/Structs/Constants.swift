//
//  Constants.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation

struct Constants {

    struct Storyboard {
        static let homeViewController = "HomeVC"
    }
    
    struct Fonts {
        static let ukNumberPlate = "UKNumberPlate"
    }

    struct Media {
        static let introVideo = "rideCheckVideo"
        static let format = "mp4"
        static let back = "return"
    }

    struct Signup {
        static let fillInFields = "Please fill in all fields"
        static let passwordError = "Please make sure your password is at least 8 characters, contains a special character and a number"
        static let resetEmail = "Please fill in your registered email"
    }

    struct UI {
        static let resetPwTitle = "Forgot your password"
        static let resetPwSubtitle = "We will send a password reset link to the registered email."
    }

    struct Alert {
        static let resetLink = "Reset link sent"
        static let resetText = "Check your email and follow instructions."
    }
}
