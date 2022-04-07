//
//  APIServiceTest.swift
//  ImageListViewTests
//
//  Created by Pravin.nagargoje on 05/04/22.
//

import XCTest
@testable import ImageListView

class APIServiceTest: XCTestCase {

    var service = ApiServer()
    var viewController: ViewController!
    
    func testAPICall() {
        let expectation = XCTestExpectation(description: "Data")
        ApiServer.shared.getApiCall(Constants.url, completionHandler: {[weak self] data, error in
            if error != nil {
                XCTFail("Fail")
            }
            expectation.fulfill()
            self?.waitForExpectations(timeout: 20, handler: nil)
        })
    }
    
    func testAPICallError() {
        let expectation = XCTestExpectation(description: "Data")
        ApiServer.shared.getApiCall("123", completionHandler: {[weak self] data, error in
            if error == nil {
                XCTFail("Fail")
            }
            expectation.fulfill()
            self?.waitForExpectations(timeout: 20, handler: nil)
        })
    }
}
