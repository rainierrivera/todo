//
//  TodoListState.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import ReSwift

struct TodoListState: StateType {
  var todos: [Todo] = []
  var showTodo = false
  var selectedTodo: Todo?
  
}
