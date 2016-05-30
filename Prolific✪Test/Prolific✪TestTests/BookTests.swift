//
//  BookTests.swift
//  Prolific✪Test
//
//  Created by Guang on 5/27/16.
//  Copyright © 2016 Guang. All rights reserved.
//
//import UIKit
import XCTest
import Alamofire
@testable import Prolific_Test






class BookTests: XCTestCase {
    var viewController: SWAGViewController!

    override func setUp() {
        super.setUp()
//        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SWAGViewController") as! SWAGViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    /*
     func testMytestFunction(){
     var HTMLResponse = NSHTTPURLResponse(URL: NSURL(string: "myurl")!, statusCode: 200, HTTPVersion: "HTTP/1.1", headerFields: nil)
     
     Request.response.data = HTMLResponse
     Request.response.json = LoadDataFromJSONFile("MyJsonFile")
     
     request(.POST, "myurl", parameters: nil, encoding: ParameterEncoding.JSON).responseJSON {
     (request, response, JSON, error) -> Void in
     // the JSON and response variable now contains exactly the data that you have passed to Request.response.data and Request.response.json
     }
     }
     
     func testExample() {
     let expectation = expectationWithDescription("Alamofire")
     
     Alamofire.request(.GET, urlString)
     .response { request, response, data, error in
     XCTAssertNil(error, "Whoops, error \(error)")
     
     XCTAssertEqual(response?.statusCode, 200, "Status code not 200")
     
     expectation.fulfill()
     }
     
     waitForExpectationsWithTimeout(5.0, handler: nil)
     }
     
     Alamofire.request(.GET, swagApi.getApi).responseJSON {
     response in
     guard response.result.error == nil
     else {
     print ("Error. \(response.result.error?.localizedDescription) and \(response.debugDescription)")
     return
     }
     print("Response.result.isSuccess: \(response.result.isSuccess)")
     
     if response.result.isSuccess {
     completion(response.result.value as! [[String: AnyObject]])
     for eachBook in response.result.value as! [[String : AnyObject]] {
     let book = self.addPropertyToBook(eachBook)
     self.bookArray.append(book)
     }
     }
     }
     
     Alamofire.request(.PUT, bookIDURL, parameters: param)
     .response { (request, response, data, error) in
     
    */
//    
//    func testURLRequest(){
//        
//        let expection = expectationWithDescription("Alamofire")
//        
//        Alamofire.request(.GET, "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?").response {
//            (request, response, data, error) in
//        
//                XCTAssertNil(error, "Error\(error)")
//                
//                XCTAssertEqual(response?.statusCode, 200, "Status code not 200")
//                
//                expection.fulfill()
//        }
//        
//        waitForExpectationsWithTimeout(5.0, handler: nil)
//    
//    }
}
