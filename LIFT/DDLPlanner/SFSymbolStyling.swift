//
//  SFSymbolStyling.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

// ViewModifier to apply specific styling to SF Symbols
struct SFSymbolStyling: ViewModifier {
  // Define the body method to specify the modifications
  func body(content: Content) -> some View {
    content
      .imageScale(.large)  // Set the image scale to large
      .symbolRenderingMode(.monochrome)  // Render the symbol in monochrome mode
  }
}

// Extension to make it easier to apply the SFSymbolStyling modifier
extension View {
  // Method to apply the SFSymbolStyling modifier to any view
  func sfSymbolStyling() -> some View {
    modifier(SFSymbolStyling())
  }
}
