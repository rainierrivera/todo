//
//  TodoReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import ReSwift

func todoReducer(action: Action, state: TodoState?) -> TodoState {
  
  let appUserDefault = AppUserDefault.shared
  let userTodos = appUserDefault.getTodos()
  
  var state = state ?? TodoState()
  
  state.todoType = .default
  guard let user = appUserDefault.getCurrentUser() else {
    return state
  }

  switch action {
  case let addTodo as AddTodoAction:
    
    userTodos.forEach { todo in
      if todo.name == addTodo.todo.name {
        state.todoType = .alreadyExist
      }
    }
    
    if state.todoType == .alreadyExist {
      return state
    }
    
    state.todoType = .addedTodo
    user.todos.append(addTodo.todo)
    appUserDefault.setCurrentUser(with: user)
    appUserDefault.saveUser(user: user)
    
  case let editAction as EditTodoAction:
    guard let selectedTodo = state.todo else { return state }
    user.todos.forEach { (userTodo) in
      if userTodo.name == selectedTodo.name {
        state.todoType = .addedTodo
        userTodo.name = editAction.todo.name
        appUserDefault.setCurrentUser(with: user)
        appUserDefault.saveUser(user: user)
      }
    }
    
  case _ as DeleteTodoAction:
    guard let selectedTodo = state.todo else { return state }
    user.todos = user.todos.filter { $0.name != selectedTodo.name }
    state.todoType = .addedTodo
    appUserDefault.setCurrentUser(with: user)
    appUserDefault.saveUser(user: user)
    
  case let doneAction as DoneTodoAction:
    guard let selectedTodo = state.todo else { return state }
    user.todos.forEach { (userTodo) in
      if userTodo.name == selectedTodo.name {
        state.todoType = .addedTodo
        userTodo.isDone = doneAction.isDone
        appUserDefault.setCurrentUser(with: user)
        appUserDefault.saveUser(user: user)
      }
    }
    
  case let todoAction as LoadTodo:
    state.todo = todoAction.todo
  default:
    state.todo = nil
    state.todoType = .default
    break
  }
  return state
}
