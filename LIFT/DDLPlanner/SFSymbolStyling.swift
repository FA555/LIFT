//
//  SFSymbolStyling.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct SFSymbolStyling: ViewModifier {
  func body(content: Content) -> some View {
    content
      .imageScale(.large)
      .symbolRenderingMode(.monochrome)
  }
}

extension View {
  func sfSymbolStyling() -> some View {
    modifier(SFSymbolStyling())
  }
}
