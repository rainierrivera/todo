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
  }
  
  init() {
    self.userDefaults = .standard
  }
  
  func saveUser(user: User) {
    do {
      let data: Data = try NSKeyedArchiver.archivedData(withRootObject: user,
                                                    requiringSecureCoding: false)
      userDefaults.set(data, forKey: "\(ConstantKeys.userKeys)-\(user.username)")
      userDefaults.synchronize()
    } catch {
      fatalError("Unable to save User")
    }
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
      return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User
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
  
  func isUserExist(with username: String) -> Bool {
    return isKeyPresentInUserDefaults(key: "\(ConstantKeys.userKeys)-\(username)")
  }
  
  func getUser(with username: String) -> User? {
    guard let data = userDefaults.data(forKey: "\(ConstantKeys.userKeys)-\(username)") else {
      return nil
    }
    do {
      return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User
    } catch {
      fatalError("loadWidgetDataArray - Can't encode data: \(error)")
    }
  }
  
  // MARK: Privates
  
  /// Use this to make Json File on local directory with selected User
  private func makeJsonFile(with user: User, fileName: String) {
    do {
      // Convert object to Data
      let data: Data = try NSKeyedArchiver.archivedData(withRootObject: user,
                                                    requiringSecureCoding: false)

      let url = FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first
      if let url = url {
        let fileUrl = url.appendingPathComponent("\(fileName).json")
        
        do {
          try data.write(to: fileUrl, options: .atomicWrite)
        } catch {
          print(error)
        }
      }
    } catch {
      fatalError("Unable to convert user to Data: - Check Decoding/Encoding")
    }
  }
  
  private func isKeyPresentInUserDefaults(key: String) -> Bool {
      return UserDefaults.standard.object(forKey: key) != nil
  }
}
