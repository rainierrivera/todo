//
//  TodoFactory.swift
//  Todo-App
//
//  Created by Collabera on 10/27/20.
//

import Foundation


struct TodoFactory {
  static func makeTodos() -> [Todo] {
    let todo1 = Todo(name: "Todo1", userId: "hello", isDone: false)
    let todo2 = Todo(name: "Todo2", userId: "hello", isDone: true)
    let todo3 = Todo(name: "Todo3", userId: "hello", isDone: true)
    return [todo1, todo2, todo3]
  }
}
