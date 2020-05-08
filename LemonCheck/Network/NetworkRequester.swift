//
//  NetworkRequester.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import Alamofire

final class RCNetworkRequest {

    let apiKey = "aeea2a18-a018-4207-a6f8-7fc6e29169f0"
    var regNumber = ""
    let dataPackage = "VdiCheckFull"
    let queryStringOptionals = "&api_nullitems=1"
    let apiVersion = 2
    var vehicleInformation: Vehicle?

    lazy var baseUrl: String = {
        return "https://uk1.ukvehicledata.co.uk/api/datapackage/\(dataPackage)?v=\(apiVersion)\(queryStringOptionals)&auth_apikey=\(apiKey)&key_VRM="
    }()

    typealias VehicleDataCompletionHandler = (Vehicle?, Error?) -> Void

    func getVehicleDataFrom(regNumber: String, completion: @escaping VehicleDataCompletionHandler) {
        AF.request(self.baseUrl + regNumber,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil).response { (responseData) in
                    guard let data = responseData.data else {return}
                    do {
                        let vehicleInfo = try JSONDecoder().decode(Vehicle.self, from: data)
                        print("Vehicle information succesfully decoded")
                        completion(vehicleInfo, nil)
                    } catch {
                        print("Error decoding == \(error)")
                        completion(nil, error)
                    }
        }
    }

}
