//
//  Todo.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import Foundation


class Todo: NSObject, NSCoding {
  var name: String
  var userId: String
  var isDone: Bool
  
  init(name: String, userId: String, isDone: Bool) {
    self.name = name
    self.userId = userId
    self.isDone = isDone
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    let userId = aDecoder.decodeObject(forKey: "userId") as? String ?? ""
    let isDone = aDecoder.decodeBool(forKey: "isDone") 
    self.init(name: name, userId: userId, isDone: isDone)
     
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(userId, forKey: "userId")
    aCoder.encode(isDone, forKey: "isDone")
  }
}
