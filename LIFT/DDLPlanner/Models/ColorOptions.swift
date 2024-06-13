//
//  ColorOptions.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftUI

enum ColorOptions: String, CaseIterable {
  case primary = "primary"
  case gray = "gray"
  case red = "red"
  case orange = "orange"
  case yellow = "yellow"
  case green = "green"
  case mint = "mint"
  case cyan = "cyan"
  case indigo = "indigo"
  case purple = "purple"
  
  static let `default` = Self.primary
  
  static var random: Self {
    return allCases.randomElement()!
  }
  
  var color: Color {
    switch self {
    case .primary:
      return .primary
    case .gray:
      return .gray
    case .red:
      return .red
    case .orange:
      return .orange
    case .yellow:
      return .yellow
    case .green:
      return .green
    case .mint:
      return .mint
    case .cyan:
      return .cyan
    case .indigo:
      return .indigo
    case .purple:
      return .purple
    }
  }
}
