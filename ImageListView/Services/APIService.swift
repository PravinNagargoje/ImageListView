//
//  APIService.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import Foundation

class ApiServer {
    static let shared = ApiServer()
    
    func getApiCall(_ strUrl: String, completionHandler:@escaping ((_ data: Data?, _ error: Error?) -> Void)) {
        guard let url = URL(string: strUrl) else {
            return
        }
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let responseStrInISOLatin = String(data: data ?? Data(), encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                return
            }
            
            completionHandler(modifiedDataInUTF8Format, error)
        }.resume()
    }
}

enum Result<Success, Error: Swift.Error> {
    case success(Success)
    case failure(Error)
}

extension Result {
    func get() throws -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

