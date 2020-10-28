//
//  User.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import Foundation


class User: NSObject, NSCoding, Codable {
  var username: String = ""
  var password: String = ""
  var todos: [Todo] = []
  
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
  
  required convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let username = try container.decode(String.self, forKey: .username)
    let password = try container.decode(String.self, forKey: .password)
    let todos = try container.decode([Todo].self, forKey: .todos)
    
    self.init(username: username, password: password, todos: todos)
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(password, forKey: "password")
    aCoder.encode(username, forKey: "username")
    aCoder.encode(todos, forKey: "todos")
  }
  
  enum CodingKeys: String, CodingKey {
    case username
    case password
    case todos
  }
}
