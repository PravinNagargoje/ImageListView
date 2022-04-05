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
        service.getApiCall(Constants.url, completionHandler: { _, error in
            if error != nil {
                XCTFail("Fail")
            }
            expectation.fulfill()
            self.waitForExpectations(timeout: 2, handler: nil)
        })
    }
}
