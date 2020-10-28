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
    DispatchQueue.main.async {
      store.dispatch(RoutingAction(destination: .todoList))
    }
  }
}


extension LoginViewController: StoreSubscriber {
  func newState(state: LoginState) {
    if state.isLogin {
      moveToDoList()
    }
  }
}
