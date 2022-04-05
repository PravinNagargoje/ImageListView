//
//  ImageListViewTests.swift
//  ImageListViewTests
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import XCTest
@testable import ImageListView

class ImageListViewTests: XCTestCase {

    let tableView = UITableView()
    let dictionaryArray = NSMutableArray()
    var myDictionary = NSMutableDictionary()
    var datasource = ImageListViewModel()
    var service = ApiServer()
    var viewController: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewController = ViewController()
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        tableView.delegate = viewController.self
        tableView.dataSource = viewController.self
        tableView.register(ImageListCell.self, forCellReuseIdentifier: Constants.cellIdentifer)
        
        for index in 1...7 {
            let item: NSDictionary = [
                "title": "title \(index)",
                "description": "description \(index)",
                "imageHref": "image \(index)"
            ]
            dictionaryArray.add(item)
        }
        self.myDictionary = ["rows": dictionaryArray]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dictionaryArray.removeAllObjects()
        self.viewController.endAppearanceTransition()
    }
  
    func testTableViewIsPresent() {
        XCTAssertNotNil(self.tableView)
    }

    func testTableViewScrolls() {
        XCTAssertNotNil(self.tableView.isScrollEnabled, "tableview is not scrollable")
    }

    func testTableViewDataSource() {
        XCTAssertNotNil(self.tableView.dataSource)
    }

    func testTableViewDelegate() {
        XCTAssertNotNil(self.tableView.delegate)
    }

    func testTableViewDelegateProtocol() {
        XCTAssertTrue(self.viewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewDataSourceProtocol() {
        XCTAssertTrue(self.viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(
            self.viewController.responds(
                to: #selector(self.viewController.tableView(_:numberOfRowsInSection:))
            )
        )
        XCTAssertTrue(
            self.viewController.responds(
            to: #selector(self.viewController.tableView(_:cellForRowAt:))
            )
        )
    }

    func testTableCellData() {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifer, for: IndexPath(row: 0, section: 0)) as? ImageListCell else {
                fatalError(Constants.error)
        }
        XCTAssertNil(cell.titleLabel.text)
        XCTAssertNil(cell.descriptionLabel.text)
        XCTAssertNil(cell.dataImageView.image)
    }
}
