//
//  ViewController.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let refreshTableView = UIRefreshControl()
    lazy var imageListViewModel = {
        ImageListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    // Initialize tableView
    private func initView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(ImageListCell.self, forCellReuseIdentifier: Constants.cellIdentifer)
        refreshTableView.addTarget(self, action: #selector(initViewModel), for: .valueChanged)
        
        refreshTableView.attributedTitle = NSAttributedString(string: Constants.refreshMessage)
        tableView.addSubview(refreshTableView)
        
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    // Initialize view model
    @objc private func initViewModel() {
        imageListViewModel.getRequiredData()
        imageListViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationItem.title = self?.imageListViewModel.tableTitle
                self?.refreshTableView.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
}

// TableView DataSource and Delegate methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageListViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ImageListCell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifer, for: indexPath
        ) as? ImageListCell else {
            fatalError(Constants.noCellError)
        }
        cell.cellViewModel = imageListViewModel.getCellData(at: indexPath)
        return cell
    }
}

