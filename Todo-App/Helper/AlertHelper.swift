//
//  AlertHelper.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import UIKit

struct AlertHelper {
  static func defaultAlert(with title: String,
                           message: String?,
                           okHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: okHandler)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    return alertController
  }
  
  static func okAlert(with title: String,
                 message: String?,
                 okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: okHandler)
    
    alertController.addAction(okAction)
    return alertController
  }
}
