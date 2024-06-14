//
//  Friend.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData

// Model class representing a Friend entity
@Model
class Friend {
  // Sample data for testing and development
  static let sampleData = [
    Friend(
      name: "Panadol", birthday: Date(timeIntervalSince1970: 1_117_900_800)
    ),
    Friend(name: "Alice", birthday: Date(timeIntervalSince1970: 0)),
    Friend(name: "Bob", birthday: Date(timeIntervalSince1970: 1_000_000_000)),
    Friend(
      name: "Charlie", birthday: Date(timeIntervalSince1970: 2 * 1_000_000_000)
    ),
    Friend(
      name: "David", birthday: Date(timeIntervalSince1970: 3 * 1_000_000_000)
    ),
    Friend(
      name: "Eve", birthday: Date(timeIntervalSince1970: 4 * 1_000_000_000)
    ),
    Friend(name: "Frank", birthday: Date(timeIntervalSince1970: 1_118_600_000)),
    Friend(name: "Grace", birthday: .now),
  ]

  // Properties of the Friend model
  var name: String
  var birthday: Date

  // Initializer to create a Friend instance
  init(name: String, birthday: Date) {
    self.name = name
    self.birthday = birthday
  }

  // Computed property to check if today is the friend's birthday
  var isBirthdayToday: Bool {
    let calendar = Calendar.current
    let today = calendar.dateComponents([.month, .day], from: Date())
    let components = calendar.dateComponents([.month, .day], from: birthday)
    return today == components
  }
}
