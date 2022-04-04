//
//  Connectivity.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import Alamofire

struct Connectivity {
    /* Check the internet connection availability */
    var isInternetAvailable: Bool {
        NetworkReachabilityManager()!.isReachable
    }
}

