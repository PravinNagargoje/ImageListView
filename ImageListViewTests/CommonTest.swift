//
//  CommonTest.swift
//  ImageListViewTests
//
//  Created by Pravin.nagargoje on 06/04/22.
//

import XCTest
@testable import ImageListView

class CommonTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlert() {
        Alert.showAlert(Constants.noInternet)
        let exp = expectation(description: Constants.noInternet)
        exp.fulfill()
        waitForExpectations(timeout: 1)
    }
}
