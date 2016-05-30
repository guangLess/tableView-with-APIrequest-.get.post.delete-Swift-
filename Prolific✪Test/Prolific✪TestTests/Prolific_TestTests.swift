//
//  Prolific_TestTests.swift
//  Prolific✪TestTests
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.
//
import Alamofire

import XCTest
@testable import Prolific_Test

class Prolific_TestTests: XCTestCase {
    
    var viewController: SWAGViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testURLRequest(){
        
        let expection = expectationWithDescription("Alamofire")
        
        Alamofire.request(.GET, "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?").response {
            (request, response, data, error) in
            
            XCTAssertNil(error, "Error\(error)")
            
            XCTAssertEqual(response?.statusCode, 200, "Status code not 200")
            
            expection.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
        
    }
    
}
