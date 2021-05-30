//
//  NetworkRequester.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation
import Alamofire

enum APIResponseError: Error {
    case networkFailure
    case dataInvalid
}

protocol LCNetworkRequestDelegate: class {
    func requestDidFinish(request: LCNetworkRequest, data: Vehicle)
    func requestDidFinish(request: LCNetworkRequest, error: APIResponseError)
}

final class LCNetworkRequest {
    
    weak var delegate: LCNetworkRequestDelegate?
    
    let apiKey = "aeea2a18-a018-4207-a6f8-7fc6e29169f0"
    var regNumber = ""
    let dataPackage1 = "VdiCheckFull"
    let dataPackage2 = "MotHistoryData"
    let queryStringOptionals = "&api_nullitems=1"
    let apiVersion = 2
    var vehicleInformation: Vehicle?
    var motInformation: MOTCheck?
    var carMake: String?
    var carColour: String?
    var carYear: String?
    var vrm: String?
    
    lazy var vdiUrl: String = {
        return "https://uk1.ukvehicledata.co.uk/api/datapackage/\(dataPackage1)?v=\(apiVersion)\(queryStringOptionals)&auth_apikey=\(apiKey)&key_VRM="
    }()
    
    lazy var motUrl: String = {
        return "https://uk1.ukvehicledata.co.uk/api/datapackage/\(dataPackage2)?v=\(apiVersion)\(queryStringOptionals)&auth_apikey=\(apiKey)&key_VRM="
    }()
    
    typealias VehicleDataCompletionHandler = (Vehicle?, Error?) -> Void
    typealias MOTDataCompletionHandler = (MOTCheck?, Error?) -> Void
    
    func getFullVehicleDataFrom(regNumber: String, completion: @escaping VehicleDataCompletionHandler) {
        AF.request(self.vdiUrl + regNumber,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil).response { (responseData) in
                    guard let data = responseData.data else {return}
                    do {
                        let vehicleInfo = try JSONDecoder().decode(Vehicle.self, from: data)
                        print("Vehicle information succesfully decoded")
                        self.delegate?.requestDidFinish(request: self, data: vehicleInfo)
                        completion(vehicleInfo, nil)
                    } catch {
                        print("Error decoding == \(error)")
                        completion(nil, error)
                    }
                   }
    }
    
    func getDVLAdata(completion: (VehicleBasicDetails?, Error?) -> Void) {
        NetworkManager.downloadPlayerProfile {
            jsonData in guard let jData = jsonData else { return }
            
            do {
                let vehicleBasicDetails = try JSONDecoder().decode(VehicleBasicDetails.self, from: jData)
                completion(vehicleBasicDetails, nil)
            } catch let err {
                completion(nil, err)
                print(err.localizedDescription)
            }
        }
    }
    
}
