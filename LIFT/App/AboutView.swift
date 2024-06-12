//
//  AboutView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        Image(systemName: "figure.roll.runningpace")

        Text("LIFT")
      }
      .font(.largeTitle)
      .fontWeight(.heavy)
      .foregroundStyle(.tint)

      Text("Lightweight Integrated Featurized Toolbox")
        .foregroundStyle(.secondary)

      List {
        HStack {
          Text("Version")

          Spacer()

          Text("0.1.0")
            .foregroundStyle(.secondary)
        }

        HStack {
          Text("Author")

          Spacer()

          Text("fa_555")
            .foregroundStyle(.secondary)
        }

        HStack {
          Text("Repository")

          Spacer()

          // make it a link
          Link("GitHub", destination: URL(string: "https://github.com/FA555")!)
            .foregroundStyle(.link)
        }
      }
      .listStyle(.plain)
      .frame(maxHeight: 200)
    }
    .padding()
  }
}

#Preview {
  AboutView()
}
