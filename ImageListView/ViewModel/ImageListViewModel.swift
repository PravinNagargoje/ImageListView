//
//  ImageListViewModel.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import Foundation
import UIKit

class ImageListViewModel: NSObject {
    
    private let constant = Constants()
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
    func getRequiredData() {
        ApiServer.shared.getApiCall(constant.url) {[weak self] data, error in
            if error == nil {
                do {
                    guard let data = data else {
                        return
                    }
                    
                    self?.cellArray.removeAll()
                    let apiData = try JSONDecoder().decode(UserData.self, from: data)
                    self?.setTableTitle(title: apiData.title)
                    for content in apiData.rows {
                        self?.setData(content: content)
                    }
                    self?.items = self?.cellArray ?? []
                } catch {
                    print(error)
                }
            } else {
                print(error as Any)
            }
        }
    }
    
    // Set Navigation Bar Title
    func setTableTitle(title: String) {
        self.tableTitle = title
    }
    
    func getCellData(at indexPath: IndexPath) -> CellData {
        cellArray[indexPath.row]
    }
}
    
extension ImageListViewModel {
    
    // Add data to array
    func setData(content: CellDataModel) {
        let dataModel = CellData(cellTitle: content.title ?? "", cellDescription: content.rowDescription ?? "", cellImage: content.imageHref ?? "")
        if content.title != nil || content.rowDescription != nil || content.imageHref != nil {
            self.cellArray.append(dataModel)
        }
    }
    
    func showAlert(_ message: String) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let alert = UIAlertController(title: constant.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: constant.ok, style: .default, handler: { _ in
                        })
        )
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
