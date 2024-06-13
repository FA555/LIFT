//
//  Task.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation

struct Task: Identifiable, Hashable {
  var id = UUID()
  var text: String
  var isCompleted = false
  var isNew = false
}
