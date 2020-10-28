//
//  AppReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
  return AppState(routerState: routingReducer(action: action, state: state?.routerState),
                  registrationState: registerReducer(action: action, state: state?.registrationState),
                  loginState: loginReducer(action: action, state: state?.loginState),
                  todoListState: todoListReducer(action: action, state: state?.todoListState),
                  todoState: todoReducer(action: action, state: state?.todoState))
}
