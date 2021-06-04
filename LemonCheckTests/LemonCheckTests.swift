//
//  LemonCheckTests.swift
//  LemonCheckTests
//
//  Created by Kazi Abdullah Al Mamun on 6/3/21.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import XCTest
@testable import LemonCheck

class LemonCheckTests: XCTestCase {

    let networkRequest = LCNetworkRequest()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDVLAdataForAU09YLV() throws {
        VehicleInput.shared.reg = "AU09YLV"
        networkRequest.getDVLAdata { vehicleDetails, error in
            XCTAssert(error == nil, "Error: \(error!.localizedDescription)")
            XCTAssert(vehicleDetails != nil, "No error occured but data is nil")
            XCTAssert(vehicleDetails?.registrationNumber != nil, "Registration number should not nil.")
            XCTAssert(vehicleDetails!.registrationNumber! == "AU09YLV", "Expected Registration number AU09YLV Got \(vehicleDetails!.registrationNumber!).")
            XCTAssert(vehicleDetails?.colour != nil, "Color should not nil")
            XCTAssert(vehicleDetails!.colour! == "ORANGE", "Expected Color Orange Got \(vehicleDetails!.colour!)")
        }
    }
    
    func testGetDVLAdataForY431JAT() throws {
        VehicleInput.shared.reg = "Y431JAT"
        networkRequest.getDVLAdata { vehicleDetails, error in
            XCTAssert(error == nil, "Error: \(error!.localizedDescription)")
            XCTAssert(vehicleDetails != nil, "No error occured but data is nil")
            XCTAssert(vehicleDetails?.registrationNumber != nil, "Registration number should not nil.")
            XCTAssert(vehicleDetails!.registrationNumber! == "Y431JAT", "Expected Registration number Y431JAT Got \(vehicleDetails!.registrationNumber!).")
            XCTAssert(vehicleDetails?.colour != nil, "Color should not nil")
            XCTAssert(vehicleDetails!.colour! == "BLUE", "Expected Color BLUE Got \(vehicleDetails!.colour!)")
        }
    }
    
    func testFullVehicleDataForAU09YLV() throws {
        networkRequest.getFullVehicleDataFrom(regNumber: "AU09YLV") { vehicle, error in
            XCTAssert(error == nil, "Error: \(error!.localizedDescription)")
            XCTAssert(vehicle != nil, "No error occured but data is nil")
            XCTAssert(vehicle!.vrm.isEmpty, "Registration number should not empty.")
            XCTAssert(vehicle!.vrm == "AU09YLV", "Expected Registration number AU09YLV Got \(vehicle!.vrm).")
            XCTAssert(!vehicle!.isWrittenOff, "Is Written off should false for AU09YLV reg number")
            XCTAssert(!vehicle!.writeOffDate.isEmpty, "Written of date should exist for reg number AU09YLV")
            XCTAssert(vehicle!.writeOffDate == "17/09/2019", "write off date should 17/09/2019 for reg number AU09YLV")
            XCTAssert(!vehicle!.writeOffCategory.isEmpty, "Write off category should not empty for reg number AU09YLV")
            XCTAssert(vehicle!.writeOffCategory == "Category N", "Write off category should Category N")
            XCTAssert(vehicle!.isFinanced, "Is Financed should true for reg number AU09YLV")
            XCTAssert(vehicle!.financeRecordList == nil, "Finance record list should nil")
        }
    }
    
    func testFullVehicleDataForY431JAT() throws {
        networkRequest.getFullVehicleDataFrom(regNumber: "Y431JAT") { vehicle, error in
            XCTAssert(error == nil, "Error: \(error!.localizedDescription)")
            XCTAssert(vehicle != nil, "No error occured but data is nil")
            XCTAssert(vehicle!.vrm.isEmpty, "Registration number should not empty.")
            XCTAssert(vehicle!.vrm == "Y431JAT", "Expected Registration number Y431JAT Got \(vehicle!.vrm).")
            XCTAssert(vehicle!.isWrittenOff, "Is Written off should true for Y431JAT reg number")
            XCTAssert(vehicle!.writeOffDate.isEmpty, "Written of date should empty for reg number Y431JAT")
            XCTAssert(vehicle!.writeOffCategory.isEmpty, "Write off category should empty for reg number Y431JAT")
            XCTAssert(vehicle!.isFinanced, "Is Financed should true for reg number Y431JAT")
            XCTAssert(vehicle!.financeRecordList == nil, "Finance record list should nil")
        }
    }

}
