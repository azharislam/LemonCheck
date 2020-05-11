//
//  MenuViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case welcome
    case home
    case myAccount
    case orderHistory
    case helpInfo
    case signout
}


class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType.init(rawValue: indexPath.row) else {return}
        dismiss(animated: true) { [weak self] in
            print("Dismissing \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }


}
