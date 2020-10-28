//
//  RoutingState.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

struct RoutingState: StateType {
  
  var routingDestination: RoutingDestination
  
  init(routingDestination: RoutingDestination = .login) {
    self.routingDestination =  routingDestination
  }
}

enum RoutingDestination: String {
  case login = "LoginViewController"
  case register = "RegisterViewController"
  case todoList = "TodoListViewController"
  case todoDetail = "TodoDetailViewController"
  case AddTodo = "AddTodoViewController"
  case pop = "pop" // Just pop the controller
}
