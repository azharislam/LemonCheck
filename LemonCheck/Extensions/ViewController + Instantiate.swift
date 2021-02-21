//
//  ViewController + Instantiate.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

extension RegistrationViewController {

    static func instantiate() -> RegistrationViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let regVC = storyboard.instantiateViewController(identifier: "RegVC") as? RegistrationViewController {
            return regVC
        }
        return nil
    }
}


extension LoginViewController {

    static func instantiate() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginVC = storyboard.instantiateViewController(identifier: "LoginVC") as? LoginViewController {
            return loginVC
        }
        return nil
    }
}


extension HomeViewController {

    static func instantiate() -> HomeViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let homeVC = storyboard.instantiateViewController(identifier: "HomeVC") as? HomeViewController {
            return homeVC
        }
        return nil
    }
}

extension VerifyVehicleViewController {

    static func instantiate() -> VerifyVehicleViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let verifyVC = storyboard.instantiateViewController(identifier: "VerifyVC") as? VerifyVehicleViewController {
            return verifyVC
        }
        return nil
    }
}

extension ResultsViewController {

    static func instantiate() -> ResultsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let resultVC = storyboard.instantiateViewController(identifier: "ResultVC") as? ResultsViewController {
            return resultVC
        }
        return nil
    }
}

extension ForgotPasswordViewController {

    static func instantiate() -> ForgotPasswordViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let forgotVC = storyboard.instantiateViewController(identifier: "ForgotVC") as? ForgotPasswordViewController {
            return forgotVC
        }
        return nil
    }
}

extension EmailVerifyViewController {

    static func instantiate() -> EmailVerifyViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let emailVC = storyboard.instantiateViewController(identifier: "EmailVC") as? EmailVerifyViewController {
            return emailVC
        }
        return nil
    }
}
