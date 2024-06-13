//
//  Task.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable, Hashable {
  var id = UUID()
  var addTime = Date.now
  var text: String
  var isCompleted: Bool
  var isNew: Bool
  
  init(text: String, isCompleted: Bool = false, isNew: Bool = false) {
    self.text = text
    self.isCompleted = isCompleted
    self.isNew = isNew
  }
  
  static func == (lhs: Task, rhs: Task) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
