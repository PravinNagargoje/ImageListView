//
//  Common.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 05/04/22.
//

import UIKit

enum Alert {
    static func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            let alert = UIAlertController(title: Constants.title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
