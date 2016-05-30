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
    //let testAPI = APIKey()


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
    
    
    func testGetRequest(){
        let expection = expectationWithDescription("Alamofire")
        Alamofire.request(.GET, "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?").response {
            (request, response, data, error) in
            XCTAssertNil(error, "Error\(error)")
            XCTAssertEqual(response?.statusCode, 200, "Status code not 200")
            expection.fulfill()
        }
        /*
        Alamofire.request(.POST, "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books").response {
            (request, response, data, error) in
            XCTAssertNil(error, "Error\(error)")
            XCTAssertEqual(response?.statusCode, 200, "Status code not 200")
            expection.fulfill()
        }
        
        */
        
        waitForExpectationsWithTimeout(5.0, handler: nil)

        
    }

    
    func testPOSTRequestWithUnicodeParameters() {
        // Given
        let postAPI = APIKey()
        let URLString = postAPI.postApi
        
        let parameters = [
            "author":"😜Testing",
            "title": "😜",
            "categories":"",
            "id":"",
            "lastCheckedOut": "",
            "lastCheckedOutBy":"",
            "publisher":"testPublisher",
            "url":"😜",
        ] as [String: AnyObject]
        
        let expectation = expectationWithDescription("request should succeed")
        
        var response: Response<AnyObject, NSError>?
        
        // When
        Alamofire.request(.POST, URLString, parameters: parameters)
            .responseJSON { closureResponse in
                response = closureResponse
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
        
        // Then
        if let response = response {
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertNotNil(response.data, "data should not be nil")
            
            if let
                JSON = response.result.value as? [String: AnyObject],
                form = JSON["form"] as? [String: AnyObject]
            {
//                XCTAssertEqual(<#T##expression1: [T : U]##[T : U]#>, <#T##expression2: [T : U]##[T : U]#>)
//                XCTAssertEqual(form["author"], parameters["author"], "author parameter value should match form value")
//                XCTAssertEqual(form["title"], parameters["title"], "title parameter value should match form value")
//                XCTAssertEqual(form["publisher"], parameters["publisher"], "publisher parameter value should match form value")
            } else {
                //XCTFail("form parameter in JSON should not be nil")
            }
        } else {
            XCTFail("response should not be nil")
        }
    }
}
