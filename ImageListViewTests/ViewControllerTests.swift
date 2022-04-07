//
//  ImageListViewTests.swift
//  ImageListViewTests
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import XCTest
@testable import ImageListView

class ViewControllerTests: XCTestCase {

    var tableView: UITableView!
    var dictionaryArray = [CellData]()
    var service = ApiServer()
    var viewController: ViewController!
    var imageListViewModel: ImageListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewController = ViewController()
        self.imageListViewModel = ImageListViewModel()
        self.tableView = viewController.tableView
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        viewController.beginAppearanceTransition(true, animated: false)
        tableView.delegate = viewController.self
        tableView.dataSource = viewController.self
        tableView.register(ImageListCell.self, forCellReuseIdentifier: Constants.cellIdentifer)
        
        for index in 1...7 {
            let item: CellData = CellData(cellTitle: "title \(index)", cellDescription: "description \(index)", cellImage: "image \(index)")
            dictionaryArray.append(item)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dictionaryArray.removeAll()
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
        XCTAssertTrue(
            self.viewController.responds(
            to: #selector(self.viewController.tableView(_:heightForRowAt:))
            )
        )
    }

    func testTableCellData() {
        viewController.imageListViewModel.cellArray = dictionaryArray
        guard let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ImageListCell else {
                fatalError(Constants.error)
        }
        
        XCTAssertEqual("title 1", cell.titleLabel.text)
        XCTAssertEqual("description 1", cell.descriptionLabel.text)
    }
}
