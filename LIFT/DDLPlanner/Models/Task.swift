//
//  Task.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData

// Model class representing a Task entity
@Model
class Task: Identifiable, Hashable {
  // Unique identifier for the Task
  var id = UUID()
  // Timestamp when the Task was added
  var addTime = Date.now
  // Text description of the Task
  var text: String
  // Flag indicating if the Task is completed
  var isCompleted: Bool
  // Flag indicating if the Task is new
  var isNew: Bool

  // Initializer to create a Task instance
  init(text: String, isCompleted: Bool = false, isNew: Bool = false) {
    self.text = text
    self.isCompleted = isCompleted
    self.isNew = isNew
  }

  // Equatable protocol conformance to compare two Task instances
  static func == (lhs: Task, rhs: Task) -> Bool {
    lhs.id == rhs.id
  }

  // Hashable protocol conformance to hash the Task instance
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
