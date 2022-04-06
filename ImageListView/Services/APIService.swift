//
//  APIService.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import Foundation

class ApiServer {
    static let shared = ApiServer()
    
    // API service to get data using URLSession
    func getApiCall(_ strUrl: String, completionHandler:@escaping ((_ newData: Any, _ error: Error?) -> Void)) {
        guard let url = URL(string: strUrl) else {
            return
        }
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            do {
                let responseStrInISOLatin = String(data: data ?? Data(), encoding: String.Encoding.isoLatin1)
                guard let newData = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    return
                }
                
                let apiData = try JSONDecoder().decode(UserData.self, from: newData)
                completionHandler(apiData, error)
            } catch {
                Alert.showAlert(Constants.parsingError)
            }
        }.resume()
    }
}
