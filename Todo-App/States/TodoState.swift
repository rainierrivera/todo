//
//  TodoState.swift
//  Todo-App
//
//  Created by Collabera on 10/27/20.
//

import ReSwift

struct TodoState: StateType {
  var addedTodo: Bool = false
  var isAlreadyExist: Bool = false
  
  var todo: Todo?
}
