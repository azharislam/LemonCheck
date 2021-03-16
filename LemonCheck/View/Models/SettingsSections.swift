//
//  SettingsSections.swift
//  LemonCheck
//
//  Created by Azhar on 16/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//
import UIKit

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    
    case Social
    case Communication
    case Help
    
    var description: String {
        switch self {
        case .Social: return "Social"
        case .Communication: return "Communications"
        case .Help: return "Help"
        }
    }
}

enum SocialOptions: Int, CaseIterable, CustomStringConvertible {
    
    case editProfile
    case logout
    
    var description: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .logout: return "Sign Out"
        }
    }
}


enum CommunicationOptions: Int, CaseIterable, CustomStringConvertible {
    
    case notifications
    case email
    case reportCrashes
    
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .email: return "Email"
        case .reportCrashes: return "Report Crashes"
        }
    }
}

enum HelpOptions: Int, CaseIterable, CustomStringConvertible {
    
    case faqs
    case privacyPolicy
    case terms
    case contact
    case appVersion
    
    var description: String {
        switch self {
        case .faqs: return "FAQ's"
        case .privacyPolicy: return "Privacy Policy"
        case .terms: return "Terms & Conditions"
        case .contact: return "Contact Us"
        case .appVersion: return "App Version: \(UIApplication.appVersion ?? "")"
        }
    }
}

extension UIApplication {
    static var appVersion: String? {
        guard let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return ""}
        return appVersion
    }
}
