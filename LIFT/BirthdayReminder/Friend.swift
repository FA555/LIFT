//
//  Friend.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData

@Model
class Friend {
  static let sampleData = [
    Friend(name: "Panadol", birthday: Date(timeIntervalSince1970: 1117900800)),
    Friend(name: "Alice", birthday: Date(timeIntervalSince1970: 0)),
    Friend(name: "Bob", birthday: Date(timeIntervalSince1970: 1000000000)),
    Friend(name: "Charlie", birthday: Date(timeIntervalSince1970: 2 * 1000000000)),
    Friend(name: "David", birthday: Date(timeIntervalSince1970: 3 * 1000000000)),
    Friend(name: "Eve", birthday: Date(timeIntervalSince1970: 4 * 1000000000)),
    Friend(name: "Frank", birthday: Date(timeIntervalSince1970: 1118600000)),
    Friend(name: "Grace", birthday: .now),
  ]
  
  var name: String
  var birthday: Date
  
  init(name: String, birthday: Date) {
    self.name = name
    self.birthday = birthday
  }
  
  var isBirthdayToday: Bool {
    let calendar = Calendar.current
    let today = calendar.dateComponents([.month, .day], from: Date())
    let components = calendar.dateComponents([.month, .day], from: birthday)
    return today == components
  }
}
