//
//  AlertController.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import UIKit

final class AlertController {
    
    static let shared = AlertController()
    
    private init() {}
    
    func showAlert(with title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        
        return alertController
    }
}
