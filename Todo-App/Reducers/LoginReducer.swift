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
  
  switch action {
  case let loginAction as LoginAction:
    guard let user = appUserDefault.getUser(with: loginAction.username),
          loginAction.password == user.password else {
      return state
    }
    
    appUserDefault.setCurrentUser(with: user)
    state.isLogin = true
    
  case _ as AutoLoginAction:
    state.isLogin = appUserDefault.getCurrentUser() != nil
  default:
    state.isLogin = false
  }
  
  return state
}

