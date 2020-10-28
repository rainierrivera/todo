//
//  RegisterReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import ReSwift

func registerReducer(action: Action, state: RegisterState?) -> RegisterState {
  let userDefault = AppUserDefault.shared
  
  var state = state ?? RegisterState()
  state.registerType = .default
  
  switch  action {
  case let registerAction as RegisterAction:
    guard !userDefault.isUserExist(with: registerAction.username) else {
      state.registerType = .userAlreadyExist
      return state
    }
    
    guard registerAction.password.count > 4 else {
      state.registerType = .shortPassword
      return state
    }
    
    let user = User(username: registerAction.username, password: registerAction.password, todos: [])
    userDefault.saveUser(user: user)
    state.registerType = .successfullyRegistered
  default:
    break
  }
  return state
}

