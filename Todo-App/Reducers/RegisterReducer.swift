//
//  RegisterReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import ReSwift

func registerReducer(action: Action, state: RegisterState?) -> RegisterState {
  let userDefault = AppUserDefault.shared
  
  let state = state ?? RegisterState()
  switch  action {
  case let registerAction as RegisterAction:
    userDefault.saveUser(user: registerAction.user)
  default:
    break
  }
  return state
}

