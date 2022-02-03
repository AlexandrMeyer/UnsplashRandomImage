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
    
    func showAlert(with title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title , message: "Image add to Favorite", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        
        return alertController
    }
}
