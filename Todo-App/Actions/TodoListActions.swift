//
//  TodoListActions.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import ReSwift

struct LoadToDoList: Action {
  let user: User
}

struct SelectTodoAction: Action {
  let index: Int
}
