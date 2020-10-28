//
//  RegisterViewController.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import UIKit

class RegisterViewController: UIViewController {

  // MARK: Privates
  
  private let userDefaults = AppUserDefault.shared
  
  @IBOutlet private weak var usernameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  
  @IBAction private func registerAction(_ anyObject: AnyObject) {
    guard usernameTextField.text?.isEmpty == false || passwordTextField.text?.isEmpty == false  else {
      return
    }
    
    let username = usernameTextField.text!
    let password = passwordTextField.text!
    
    guard !userDefaults.isUserExist(with: username) else {
      // Already registered
      return
    }
    
    let user = User(username: username, password: password, todos: [] )
    
    DispatchQueue.main.async {
      store.dispatch(RegisterAction(user: user))
      store.dispatch(RoutingAction(destination: .pop))
    }
    
    
  }
}
