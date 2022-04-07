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
    var dataArray = [CellDataModel]()
    var myDictionary: UserData!
    var viewController: ViewController!
    
    override func setUpWithError() throws {
        self.imageListViewModel = ImageListViewModel()
        self.addData()
        self.myDictionary = UserData(title: "About Canada", rows: dataArray)
    }

    override func tearDownWithError() throws {
        dataArray.removeAll()
    }

    func addData() {
        for index in 1...7 {
            let item: CellDataModel = CellDataModel(title: "title \(index)", rowDescription: "description \(index)", imageHref: "image \(index)")
            dataArray.append(item)
        }
        let item2: CellDataModel = CellDataModel(title: nil, rowDescription: nil, imageHref: nil)
        dataArray.append(item2)
        let item3: CellDataModel = CellDataModel(title: "", rowDescription: "", imageHref: "")
        dataArray.append(item3)
    }
    
    func testExample() throws {
        imageListViewModel.retriveAndSetData(data: "")
        imageListViewModel.retriveAndSetData(data: myDictionary as Any)
        XCTAssert(imageListViewModel.cellArray.count > 0)
    }
    
    func testCellData() {
        imageListViewModel.retriveAndSetData(data: myDictionary as Any)
        let data = imageListViewModel.getCellData(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(data.cellTitle, "title 1")
    }
}
