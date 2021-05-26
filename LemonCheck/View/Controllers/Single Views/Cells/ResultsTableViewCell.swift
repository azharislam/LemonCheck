//
//  ResultsTableViewCell.swift
//  LemonCheck
//
//  Created by Az on 03/02/2021.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    typealias SubData = (title: String, data: String)
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var subDataContainer: UIStackView!
    
    var isGreen = true
    
    private func subDataContainerView(subData: SubData) -> UIView {
        
        let container = UIView()
        
        let divider = UIView()
        divider.backgroundColor = UIColor(named: "InactiveGray")
        container.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "DMSans-Regular", size: 17)
        titleLabel.textColor = UIColor(named: "CharcoalGray")
        titleLabel.text = subData.title
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let dataLabel = UILabel()
        dataLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        dataLabel.textColor = UIColor(named: "InactiveGray")
        dataLabel.text = subData.data
        dataLabel.textAlignment = .right
        container.addSubview(dataLabel)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 7),
            titleLabel.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -14),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 7),
            
            dataLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -7),
            dataLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            divider.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        return container
    }
    
    private func subDataFinancedContainerView(subData: String) -> UIView {
        
        let container = UIView()
        
        let divider = UIView()
        divider.backgroundColor = UIColor(named: "InactiveGray")
        container.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        let dataLabel = UILabel()
        dataLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        dataLabel.textColor = UIColor(named: "InactiveGray")
        dataLabel.text = subData
        dataLabel.textAlignment = .right
        container.addSubview(dataLabel)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 7),
            dataLabel.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -14),
            dataLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            
            divider.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        return container
    }
    
    override func prepareForReuse() {
        resultLabel.text = ""
        iconImage.image = nil
        subDataContainer.arrangedSubviews.forEach { subviews in
            subviews.removeFromSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureView()
    }
    
    private func configureView() {
        if isGreen {
            self.iconImage.image = UIImage(named: "Check")
        } else {
            self.iconImage.image = UIImage(named: "Close")
        }
    }
    
    func configure(label: String, subDatas: [SubData] = [SubData](), subFinanceDatas: [String] = [String]()) {
        self.resultLabel.text = label
        print("SubData for \(label) is \(subDatas.count)")
        
        if subFinanceDatas.count > 0 {
            subFinanceDatas.forEach { subFinanceData in
                let view = subDataFinancedContainerView(subData: subFinanceData)
                subDataContainer.addArrangedSubview(view)
            }
        } else {
            subDatas.forEach { subdata in
                let view = subDataContainerView(subData: subdata)
                subDataContainer.addArrangedSubview(view)
            }
        }
    }
}
