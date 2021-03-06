//
//  Assignment_TinderTests.swift
//  Assignment-TinderTests
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import XCTest
@testable import Assignment_Tinder

class Assignment_TinderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchTODOList() {
       let exp = expectation(description:"fetching to-do list from server")
       
       let session: URLSession = URLSession(configuration: .default)
       let url = URL(string: "https://randomuser.me/api/?results=50")
       session.dataTask(with: url!) { data, response, error in
          XCTAssertNil(error)
          exp.fulfill()
       }.resume()
       waitForExpectations(timeout: 10.0) { (error) in
          print(error?.localizedDescription ?? "error")
       }
    }
}
