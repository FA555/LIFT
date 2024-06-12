//
//  Item.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import Foundation
import SwiftData

@Model
final class TestItem {
  var timestamp: Date
  
  init(timestamp: Date) {
    self.timestamp = timestamp
  }
}
