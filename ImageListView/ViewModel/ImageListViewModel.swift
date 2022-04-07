//
//  ImageListViewModel.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import Foundation
import UIKit

class ImageListViewModel: NSObject {
    
    var items = [CellData]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var cellArray = [CellData]() {
        didSet {
            reloadTableView?()
        }
    }
    var tableTitle: String?
    var reloadTableView: (() -> Void)?
    
    // Call data API
    func getRequiredData(url: String) {
        if Connectivity().isInternetAvailable {
            ApiServer.shared.getApiCall(url) {[weak self] data, error in
                if error == nil {
                    self?.retriveAndSetData(data: data)
                } else {
                    Alert.showAlert(Constants.error)
                }
            }
        } else {
            Alert.showAlert(Constants.noInternet)
        }
    }
    
    func retriveAndSetData(data: Any) {
        self.cellArray.removeAll()
        guard let apiData = data as? UserData else {
            return
        }
        self.setTableTitle(title: apiData.title)
        for content in apiData.rows {
            self.setData(content: content)
        }
        self.items = self.cellArray
    }
    
    // Set Navigation Bar Title
    func setTableTitle(title: String) {
        self.tableTitle = title
    }
    
    func getCellData(at indexPath: IndexPath) -> CellData {
        cellArray[indexPath.row]
    }
}
    
private extension ImageListViewModel {
    
    // Add data to array
    private func setData(content: CellDataModel) {
        let dataModel = CellData(cellTitle: content.title ?? "", cellDescription: content.rowDescription ?? "", cellImage: content.imageHref ?? "")
        if content.title != nil || content.rowDescription != nil || content.imageHref != nil {
            self.cellArray.append(dataModel)
        }
    }
}
