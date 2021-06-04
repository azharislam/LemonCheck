//
//  NetworkManager.swift
//  LemonCheck
//
//  Created by Biz Karimi on 25/10/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import Foundation

public var carProfileJSON = ""

//Obtaining vehicle data from DVLA
public func getCarDetails(regNumber:String) {

    let key = "ep9TIKugLb30vE2wSfiUW9z9z7FelQtI4H3rQ3kN" //dvla key, keep safe
    let url = URL(string: "https://driver-vehicle-licensing.api.gov.uk/vehicle-enquiry/v1/vehicles")
    let contentType = "application/json"
    let reg: Data? = "{\"registrationNumber\": \"\(regNumber)\"}".data(using: .utf8)
    var request = URLRequest(url: url!)
    var dvlaDecoder: String = ""
    
    
    //Converting cURL to URLRequest
    request.httpMethod = "POST"
    request.addValue(key, forHTTPHeaderField: "x-api-key")
    request.addValue(contentType, forHTTPHeaderField: "Content-Type")
    request.httpBody = reg

    
    URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        guard error == nil
            else {
            print(error!.localizedDescription); return
        }
        
        
        guard let data = data
            else {
                print("Empty data"); return
        }

        
        if let str = String(data: data, encoding: .utf8) {
            print(str)
            }
        
        
        //Setting dvlaDecoder as the data received by the server (vehicle info)
        dvlaDecoder = String(decoding: data, as: UTF8.self)
    }.resume()
    
    
    //waiting for server response to fill dvlaCoder with vehicle data
    while (dvlaDecoder == "") {
    }
    
    
    //returning server response
    carProfileJSON = dvlaDecoder
}


public class NetworkManager {
    static func downloadPlayerProfile(completion:((_ json: Data?) -> Void)) {
        getCarDetails(regNumber: VehicleInput.shared.reg!)
        completion(Data(carProfileJSON.utf8))
    }
}
