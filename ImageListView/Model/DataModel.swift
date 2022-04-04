//
//  DataModel.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import Foundation

// MARK: - UserData
struct UserData: Codable {
    let title: String
    let rows: [CellDataModel]
}

// MARK: - Row
struct CellDataModel: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}

struct CellData {
    var cellTitle: String
    var cellDescription: String
    var cellImage: String
}
