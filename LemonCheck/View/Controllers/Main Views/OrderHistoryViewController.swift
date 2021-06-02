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
    let cellIdentifier = "OrderCell"
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    var orders: [UserSearch]?
    let verifyVehicle = VerifyVehicleViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: OrderTableViewCell.className, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        verifyVehicle.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchOrders()
    }
    /// - Fetch orders from Core Data to display in TableView
    
    func fetchOrders() {
        
        do {
            self.orders = try context.fetch(UserSearch.fetchRequest())
            
            DispatchQueue.main.async {
                self.orders?.reverse()
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderTableViewCell else { return UITableViewCell()}
        
        // Get order from array
        //let order = self.orders?[(self.orders!.count - 1) - indexPath.row]
        let order = self.orders?[indexPath.row]
        cell.configureLabel(make: order?.make ?? "N/A", model: order?.model ?? "N/A", vim: order?.vrm ?? "N/A")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let orders = orders else { return }
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ResultVC") as? ResultsViewController else {return}
        vc.vehicle = orders[indexPath.row].getVehicleModel()
        vc.colour = orders[indexPath.row].colour
        vc.isFromOrderHistory = true
        self.present(vc, animated: true, completion: nil)
    }
}
