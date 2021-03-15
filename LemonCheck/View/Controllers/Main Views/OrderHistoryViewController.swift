//
//  OrderHistoryViewController.swift
//  LemonCheck
//
//  Created by Azhar on 15/03/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import Foundation
import UIKit

class OrderHistoryViewController: UIViewController, UpdateOrderHistoryDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    var orders: [UserSearch]?
    let verifyVehicle = VerifyVehicleViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        fetchOrders()
        verifyVehicle.delegate = self
    }
    
    /// - Fetch orders from Core Data to display in TableView
    
    func fetchOrders() {
        
        do {
            self.orders = try context.fetch(UserSearch.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("Error fetching orders from Core Data")
        }
    }
    
    func updateTableView(finished: Bool) {
        guard finished else {
            print("No user orders yet")
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderTableViewCell else { return UITableViewCell()}
        
        // Get order from array
        let order = self.orders?[indexPath.row]
        cell.numberPlateView.configureLabel(vrm: order?.vrm ?? "EXPIRED")
        cell.configureLabel(make: order?.make ?? "N/A", model: order?.model ?? "N/A")
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove") { (action, view, completionHandler) in
            
            // Which order to remove
            if let orderToRemove = self.orders?[indexPath.row] {
                
                // Remove order
                self.context.delete(orderToRemove)
                
                // Save data
                do {
                    try self.context.save()
                } catch {
                    print("Error deleting data")
                }
                
                // Refetch data
                self.fetchOrders()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}
