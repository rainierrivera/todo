//
//  AppState.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

struct AppState: StateType {
  let routerState: RoutingState
  let registrationState: RegisterState
  let loginState: LoginState
  let todoListState: TodoListState
  let todoState: TodoState
}
