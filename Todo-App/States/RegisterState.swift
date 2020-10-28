//
//  RegisterState.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

enum RegisterType {
  case userAlreadyExist
  case successfullyRegistered
  case shortPassword
  case `default`
}

struct RegisterState: StateType {
  var registerType: RegisterType = .default
}
