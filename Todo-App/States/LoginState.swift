//
//  LoginState.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

struct LoginState: StateType {
  var isLogin: Bool = false
  init (isLogin: Bool = false) {
    self.isLogin = isLogin
  }

}


