//
//  OrderHistoryViewController.swift
//  LemonCheck
//
//  Created by Azhar on 15/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

class OrderHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate)
    
    // Data for the table
    var orders: [UserSearch]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        fetchOrders()
    }
    
    func fetchOrders() {
        
    }
    
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderTableViewCell else { return UITableViewCell()}
        cell.numberPlateView.configureLabel(vrm: "LC06NAO")
        cell.configureLabel(make: "BMW", model: "5 SERIES COUPE")
        return cell
    }
    
    
}
