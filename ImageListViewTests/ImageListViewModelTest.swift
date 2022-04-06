//
//  ViewModelTests.swift
//  ImageListViewTests
//
//  Created by Pravin.nagargoje on 06/04/22.
//

import XCTest
@testable import ImageListView

class ImageListViewModelTest: XCTestCase {

    var imageListViewModel: ImageListViewModel!
    var dataArray = NSMutableArray()
    var myDictionary = NSMutableDictionary()
    
    override func setUpWithError() throws {
        self.imageListViewModel = ImageListViewModel()
        for index in 1...7 {
            let item: NSDictionary = [
                "title": "title \(index)",
                "description": "description \(index)",
                "imageHref": "image \(index)"
            ]
            dataArray.add(item)
        }
        self.myDictionary = ["title":"About Canada","rows": dataArray]
    }

    override func tearDownWithError() throws {
        dataArray.removeAllObjects()
    }

    func testExample() throws {
        imageListViewModel.retriveAndSetData(data: myDictionary as Any)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
