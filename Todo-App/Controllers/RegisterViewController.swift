//
//  RegisterViewController.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

class RegisterViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    store.subscribe(self) {
      $0.select {
        $0.registrationState
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    store.unsubscribe(self)
  }
  
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
    
    DispatchQueue.main.async {
      store.dispatch(RegisterAction(username: username, password: password))
    }
    
  }
  
  private func showAlert(withState state: RegisterState) {
    
    let action: ((UIAlertAction) -> Void)? = { _ in
      store.dispatch(RoutingAction(destination: .pop))
    }
    
    let alert: UIAlertController!
    
    switch state.registerType {
    case .successfullyRegistered:
      alert = AlertHelper.okAlert(with: "Successfully Registered", message: nil, okHandler: action)
    case .userAlreadyExist:
      alert = AlertHelper.okAlert(with: "User Already Exist", message: nil, okHandler: nil)
    case .shortPassword:
      alert = AlertHelper.okAlert(with: "Password should be more than 4 characters.", message: nil, okHandler: nil)
    default:
      return
    }
    
    present(alert, animated: true, completion: nil)
    
  }
}

// MARK: Extensions

extension RegisterViewController: StoreSubscriber {
  func newState(state: RegisterState) {
    DispatchQueue.main.async { [weak self] in
      self?.showAlert(withState: state)
    }
  }
}
