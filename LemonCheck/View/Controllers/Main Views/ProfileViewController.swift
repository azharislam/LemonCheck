//
//  ProfileViewController.swift
//  LemonCheck
//
//  Created by Azhar on 15/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let reuseIdentifier = "SettingsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.frame = view.frame
        tableView.tableFooterView = UIView()
    }
    
    private func configureUI() {
        configureTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .yellow
        navigationItem.title = "Settings"
    }
    
    //    @IBAction func logoutTapped(_ sender: Any) {
    //        UserDefaults.standard.set(false, forKey: "status")
    //        Switcher.updateRootVC()
    //    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection.init(rawValue: section) else { return 0}
        
        switch section {
        case .Social: return SocialOptions.allCases.count
        case .Communication: return CommunicationOptions.allCases.count
        case .Help: return HelpOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "OffWhite")
        
        let title = UILabel()
        title.font = UIFont(name: "DMSans-Regular", size: 16)
        title.textColor = UIColor(named: "CharcoalGray")
        
        title.text = SettingsSection.init(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingsCell else { return UITableViewCell()}
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        cell.backgroundColor = UIColor(named: "OffWhite")
        switch section {
        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            cell.sectionType = social
        case .Communication:
            let communications = CommunicationOptions(rawValue: indexPath.row)
            cell.sectionType = communications
        case .Help:
            let help = HelpOptions(rawValue: indexPath.row)
            cell.sectionType = help
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section),
              let social = SocialOptions(rawValue: indexPath.row),
              let comms = CommunicationOptions(rawValue: indexPath.row),
              let help = HelpOptions(rawValue: indexPath.row) else { return }
        
        switch section {
        case .Social:
            switch social {
            case .editProfile:
                print("Edit Profile tapped")
            case .logout:
                UserDefaults.standard.set(false, forKey: "status")
                Switcher.updateRootVC()
            }
        case .Communication:
            switch comms {
            case .notifications: print("Notifications tapped")
            case .email: print("Email tapped")
            case .reportCrashes: print("Report crashes tapped")
            }
        case .Help:
            switch help {
            case .faqs: print("FAQ's tapped")
            case .terms: print("Terms and Conditions tapped")
            case .privacyPolicy: print("Privacy policy tapped")
            case .contact: print("Contact tapped")
            case .appVersion: print("App version tapped")
            }
        }
        
    }
    
    
}
