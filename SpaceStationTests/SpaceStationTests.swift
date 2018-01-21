//
//  SpaceStationTests.swift
//  SpaceStationTests
//
//  Created by Frederick C. Lee on 1/21/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import XCTest
@testable import SpaceStation

class SpaceStationTests: XCTestCase {
    var url: URL?
    override func setUp() {
        super.setUp()
        let satelliteURIString = "http://api.open-notify.org/iss-pass.json?lat=\(37.323)&lon=\(-122.031)"
        url = URL(string:satelliteURIString)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let satelliteResource = SatResource(url: url!) {(data) -> Data? in
            return data
        }
        SatelliteService().load(resource: satelliteResource) {result in
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
