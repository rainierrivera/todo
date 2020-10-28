//
//  LoginReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

func loginReducer(action: Action, state: LoginState?) -> LoginState {
  
  let appUserDefault = AppUserDefault.shared
  
  var state = state ?? LoginState()
  state.loginType = .default
  switch action {
  case let loginAction as LoginAction:
    guard let user = appUserDefault.getUser(with: loginAction.username),
          loginAction.password == user.password else {
      state.loginType = .invalidCredentials
      return state
    }
    
    appUserDefault.setCurrentUser(with: user)
    state.loginType = .successfullyLogin
    
  case _ as AutoLoginAction:
    state.loginType = appUserDefault.getCurrentUser() != nil ? .successfullyLogin : .default
  default:
    state.loginType = .default
  }
  
  return state
}

