//
//  Switcher.swift
//  LemonCheck
//
//  Created by Azhar on 14/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
       
            print(status)
        

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabVC") as! UITabBarController
        }else{
           // rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            rootVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateInitialViewController()
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
