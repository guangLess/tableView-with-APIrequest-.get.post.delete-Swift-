//
//  BookTests.swift
//  Prolific✪Test
//
//  Created by Guang on 5/27/16.
//  Copyright © 2016 Guang. All rights reserved.
//
//import UIKit
import XCTest
@testable import Prolific_Test






class BookTests: XCTestCase {
    var viewController: SWAGViewController!

    override func setUp() {
        super.setUp()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SWAGViewController") as! SWAGViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
