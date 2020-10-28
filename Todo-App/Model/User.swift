//
//  User.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import Foundation


class User: NSObject, NSCoding {
  var username: String
  var password: String
  var todos: [Todo]
  
  init(username: String, password: String, todos: [Todo]) {
    self.username = username
    self.password = password
    self.todos = todos
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    let username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
    let todos = aDecoder.decodeObject(forKey: "todos") as? [Todo] ?? []
    let password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
    
    self.init(username: username, password: password, todos: todos)
     
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(password, forKey: "password")
    aCoder.encode(username, forKey: "username")
    aCoder.encode(todos, forKey: "todos")
  }
}
