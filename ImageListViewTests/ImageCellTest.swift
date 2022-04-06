//
//  ImageCellTest.swift
//  ImageListViewTests
//
//  Created by Pravin.nagargoje on 06/04/22.
//

import XCTest
@testable import ImageListView

class ImageCellTest: XCTestCase {

    var imageListCell: ImageListCell!
    var myDictionary = NSMutableDictionary()
    let dictionaryArray = NSMutableArray()

    override func setUpWithError() throws {
        self.imageListCell = ImageListCell(style: .default, reuseIdentifier: Constants.cellIdentifer)
        for index in 1...7 {
            let item: NSDictionary = [
                "title": "title \(index)",
                "description": "description \(index)",
                "imageHref": "image \(index)"
            ]
            dictionaryArray.add(item)
        }
    }

    override func tearDownWithError() throws {
        dictionaryArray.removeAllObjects()
    }
 
    func testSetData() throws {
        imageListCell.cellViewModel = dictionaryArray[0] as? CellData
        XCTAssert(!(imageListCell.cellViewModel?.cellTitle.isEmpty ?? false))
    }
}
