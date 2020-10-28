//
//  TodoState.swift
//  Todo-App
//
//  Created by Collabera on 10/27/20.
//

import ReSwift

enum TodoType {
  case addedTodo
  case alreadyExist
  case `default`
}
struct TodoState: StateType {
  var todoType: TodoType = .default
  
  var todo: Todo?
}
