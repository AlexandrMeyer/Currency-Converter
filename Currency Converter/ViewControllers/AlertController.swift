//
//  AlertController.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import UIKit

final class AlertController {
    
    static let shared = AlertController()
    
    private init() {}
    
    func showAlert(with title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(oKAction)
        
        return alertController
    }
}
