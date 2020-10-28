//
//  LoginViewController.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

class LoginViewController: UIViewController {
  
  @IBOutlet private weak var usernameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

  
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: true)
    store.subscribe(self) {
      $0.select {
        $0.loginState
      }
    }
    
    DispatchQueue.main.async {
      store.dispatch(RoutingAction(destination: .login))
      store.dispatch(AutoLoginAction())
    }
  
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    store.unsubscribe(self)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  // MARK: Privates
  
  @IBAction private func registerAction() {
    let routerDestination: RoutingDestination = .register
    
    store.dispatch(RoutingAction(destination: routerDestination))
  }
  
  @IBAction private func loginAction() {
    if usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
      return
    }
    
    let username = usernameTextField.text!
    let password = passwordTextField.text!
    
    DispatchQueue.main.async {
      store.dispatch(LoginAction(username: username, password: password))
    }
  }
  
  private func moveToDoList() {
    usernameTextField.text = ""
    passwordTextField.text = ""
    view.endEditing(true)
    store.dispatch(RoutingAction(destination: .todoList))
  }
  
  private func invalidCredentials() {
    let alert = AlertHelper.okAlert(with: "Invalid Credentials", message: nil)
    present(alert, animated: true, completion: nil)
  }
}


extension LoginViewController: StoreSubscriber {
  func newState(state: LoginState) {
    DispatchQueue.main.async { [weak self] in
      switch state.loginType {
      case .successfullyLogin:
        self?.moveToDoList()
      case .invalidCredentials:
        self?.invalidCredentials()
      default: break
      }
    }
  }
}
