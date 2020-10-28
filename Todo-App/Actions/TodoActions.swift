//
//  TodoActions.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import ReSwift

struct AddTodoAction: Action {
  let todo: Todo
}

struct EditTodoAction: Action {
  let todo: Todo
}

struct DeleteTodoAction: Action {
  let todo: Todo
}

struct DoneTodoAction: Action {
  let todo: Todo
  let isDone: Bool
}

struct LoadTodo: Action {
  let todo: Todo
}
