//
//  Todo.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import Foundation


class Todo: NSObject, NSCoding, Codable, Comparable {
  var name: String = ""
  var userId: String = ""
  var isDone: Bool = false
  var date: Date = Date()
  
  init(name: String, userId: String, isDone: Bool, date: Date = Date()) {
    self.name = name
    self.userId = userId
    self.isDone = isDone
    self.date = date
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    let userId = aDecoder.decodeObject(forKey: "userId") as? String ?? ""
    let isDone = aDecoder.decodeBool(forKey: "isDone")
    let date = aDecoder.decodeObject(forKey: "date") as? Date ?? Date()
    self.init(name: name, userId: userId, isDone: isDone, date: date)
     
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(userId, forKey: "userId")
    aCoder.encode(isDone, forKey: "isDone")
    aCoder.encode(date, forKey: "date")
  }
  
  required convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let name = try container.decode(String.self, forKey: .name)
    let userId = try container.decode(String.self, forKey: .userId)
    let isDone = try container.decode(Bool.self, forKey: .isDone)
    let date = try container.decode(Date.self, forKey: .date)
    self.init(name: name, userId: userId, isDone: isDone, date: date)
  }
  
  enum CodingKeys: String, CodingKey {
    case name
    case userId
    case isDone
    case date
  }
}

extension Todo {
  static func < (lhs: Todo, rhs: Todo) -> Bool {
    lhs.date.compare(rhs.date) == .orderedAscending
  }
  
  static func >(lhs: Todo, rhs: Todo) -> Bool {
    return lhs.date.compare(rhs.date) == .orderedDescending
  }
}
