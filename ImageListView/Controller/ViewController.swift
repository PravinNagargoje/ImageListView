//
//  ViewController.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private let refreshTableView = UIRefreshControl()
    private let constant = Constants()
    lazy var imageListViewModel = {
        ImageListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    private func initView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(ImageListCell.self, forCellReuseIdentifier: constant.cellIdentifer)
        refreshTableView.addTarget(self, action: #selector(initViewModel), for: .valueChanged)
        
        refreshTableView.attributedTitle = NSAttributedString(string: constant.refreshMessage)
        tableView.addSubview(refreshTableView)
        
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
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
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageListViewModel.listCellViewModels.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageListCell = tableView.dequeueReusableCell(
            withIdentifier: constant.cellIdentifer, for: indexPath
        ) as! ImageListCell
        cell.cellViewModel = imageListViewModel.getCellData(at: indexPath)
        return cell
    }
}

