//
//  ContentView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      ToolsView()
        .tabItem {
          Image(systemName: "wrench.and.screwdriver.fill")
          Text("Toolbox")
        }
      
      AboutView()
        .tabItem {
          Image(systemName: "info.circle")
          Text("About")
        }
    }
  }
}

#Preview {
  ContentView()
}
