//
//  LoginState.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

enum LoginType {
  case successfullyLogin
  case invalidCredentials
  case `default`
}

struct LoginState: StateType {
  var loginType: LoginType = .default
}


