//
//  TodoListReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import ReSwift

func todoListReducer(action: Action, state: TodoListState?) -> TodoListState {
  
  let userDefaults = AppUserDefault.shared
  
  var state = state ?? TodoListState()
  
  state.showTodo = false
  state.selectedTodo = nil
  
  guard let user = userDefaults.getCurrentUser() else {
    return state
  }
  
  switch action {
  case _ as LoadToDoList:
    state.todos = user.todos
  case let selectedTodoAction as SelectTodoAction:
    let todo = user.todos[selectedTodoAction.index]
    state.showTodo = true
    state.selectedTodo = todo
  default:
    break
  }
  
  return state
}

