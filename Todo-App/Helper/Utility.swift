//
//  Utility.swift
//  Todo-App
//
//  Created by Collabera on 10/28/20.
//

import Foundation

class Utility {
  
  static let shared = Utility()
  // MARK: Privates
  
  private let appUserDefaults = AppUserDefault.shared
  
  /// Use this to make Json File on local directory with selected User
  func makeJsonFile() {
    let users = appUserDefaults.getAllUsers()
    guard !users.isEmpty else { return }
    do {
      // Convert object to Data
      
      let jsonEncoder = JSONEncoder()
      let jsonData = try jsonEncoder.encode(users)

      let url = FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first
      
    
      if let url = url {
        let fileUrl = url.appendingPathComponent("todousers.json")

        do {
          try jsonData.write(to: fileUrl, options: [])
        } catch {
          print(error)
        }
      }
    } catch {
      fatalError("Unable to convert user to Data: - Check Decoding/Encoding")
    }
  }
  
  func retrieveUserFromJsonFile() -> [User]? {
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    if let url = url {
      let fileUrl = url.appendingPathComponent("todousers.json")
      
      do {
        let data = try Data(contentsOf: fileUrl, options: [])
        let users = try JSONDecoder().decode([User].self, from: data)
        return users
      } catch {
        print(error)
        return nil
      }
    }
    return nil
  }
  
}
