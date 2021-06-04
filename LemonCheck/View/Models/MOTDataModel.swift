//
//  VehicleModel.swift
//  LemonCheck
//
//  Created by Azhar Islam on 10/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation

struct MOTCheck: Codable {
    let responseMOT : ResponseMOT?

    enum CodingKeys: String, CodingKey {
        case responseMOT = "Response"
    }
}

struct ResponseMOT: Codable {
    let dataItemsMOT: DataItemsMOT?

    enum CodingKeys: String, CodingKey {
        case dataItemsMOT = "DataItems"
    }
}
struct DataItemsMOT: Codable {
    let vehicleDetails: VehicleDetails?

    enum CodingKeys: String, CodingKey {
           case vehicleDetails = "VehicleDetails"
    }
}

struct VehicleDetails: Codable {
    let make: String?
    let model: String?
    let colour: String?
    let year: String?

    enum CodingKeys: String, CodingKey {
        case make = "Make"
        case model = "Model"
        case colour = "Colour"
        case year = "DateFirstRegistered"
    }
}

struct VehicleBasicDetails: Codable {
    let registrationNumber: String?
    let co2Emissions, engineCapacity: Int?
    let markedForExport: Bool?
    let fuelType, motStatus, colour, make: String?
    let typeApproval: String?
    let yearOfManufacture: Int?
    let taxDueDate, taxStatus, dateOfLastV5CIssued, motExpiryDate: String?
    let wheelplan, monthOfFirstRegistration: String?
}
