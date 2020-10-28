//
//  AppUserDefault.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import Foundation

class AppUserDefault {
  static let shared = AppUserDefault()
  
  private let userDefaults: UserDefaults
  
  private struct ConstantKeys {
    static let userKeys = "User"
    static let todosKeys = "todos"
    static let currentUser = "currentUser"
    static let allUsers = "allUsers"
  }
  
  init() {
    self.userDefaults = .standard
  }
  
  func saveUser(user: User) {
    addSaveUser(user: user)
  }
  
  func getTodos() -> [Todo] {
    guard let user = getCurrentUser() else {
      return []
    }
    
    return user.todos
  }
  
  func getCurrentUser() -> User? {
    guard let data = userDefaults.data(forKey: "currentUser") else {
      return nil
    }
    
    do {
      guard let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User else {
        return nil
      }
      
      return  getAllUsers().filter { user.username == $0.username }.first
      
    } catch {
      fatalError("loadWidgetDataArray - Can't encode data: \(error)")
    }
  }
  
  
  func setCurrentUser(with user: User) {
    do {
      let data: Data = try NSKeyedArchiver.archivedData(withRootObject: user,
                                                    requiringSecureCoding: false)
      userDefaults.set(data, forKey: ConstantKeys.currentUser)
      userDefaults.synchronize()
    } catch {
      fatalError("Unable to save todos")
    }
  }
  
  func deleteCurrentUser() {
    // Make sure to have current user before deleting anything
    guard getCurrentUser() != nil else { return }
    userDefaults.removeObject(forKey: "currentUser")
    userDefaults.synchronize()
  }
  
  func getUser(with username: String) -> User? {
    let users = getAllUsers()
    return users.filter { $0.username == username }.first
  }
  
  func isUserExist(with username: String) -> Bool {
    let users = getAllUsers()
    return users.filter { $0.username == username }.first != nil
  }
  
  func getAllUsers() -> [User] {
    guard let data = userDefaults.data(forKey: ConstantKeys.allUsers) else {
      return []
    }
    do {
      return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [User] ?? []
    } catch {
      fatalError("loadWidgetDataArray - Can't encode data: \(error)")
    }
  }
  
  // MARK: Privates
  
  private func addSaveUser(user: User) {
    var users = [User]()
    if getAllUsers().count > 0 {
      users = getAllUsers()
    }
  
    if isUserExist(with: user.username) {
      users.first { $0.username == user.username }?.todos = user.todos
    } else {
      users.append(user)
    }
    do {
      let data: Data = try NSKeyedArchiver.archivedData(withRootObject: users,
                                                    requiringSecureCoding: false)
      userDefaults.set(data, forKey: ConstantKeys.allUsers)
      userDefaults.synchronize()
      Utility.shared.makeJsonFile()
    } catch {
      fatalError("Unable to save User")
    }
  }
}
