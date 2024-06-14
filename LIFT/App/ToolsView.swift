//
//  ToolsView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct ToolsInnerView: View {
  var body: some View {
    List {
      NavigationLink {
        SeismometerPickerView()
      } label: {
        HStack {
          Image(systemName: "metronome")
            .foregroundStyle(.tint)
            .padding()
            .font(.title2)

          VStack(alignment: .leading, spacing: 8) {
            Text("Seismometer")
              .font(.headline)

            Text("Measures the device’s vibrations.")
              .font(.caption)
          }
          .padding(.trailing)
        }
      }
      .padding([.top, .bottom])

      NavigationLink {
        EventListView()
      } label: {
        HStack {
          Image(systemName: "calendar")
            .foregroundStyle(.tint)
            .padding()
            .font(.title2)

          VStack(alignment: .leading, spacing: 8) {
            Text("Event Planner")
              .font(.headline)

            Text("Helps you plan your deadlines.")
              .font(.caption)
          }
          .padding(.trailing)
        }
      }
      .padding([.top, .bottom])

      NavigationLink {
        FilteredFriendsListView()
      } label: {
        HStack {
          Image(systemName: "gift")
            .foregroundStyle(.tint)
            .padding()
            .font(.title2)

          VStack(alignment: .leading, spacing: 8) {
            Text("Birthday Reminder")
              .font(.headline)

            Text("Organises all your friends' birthdays.")
              .font(.caption)
          }
          .padding(.trailing)
        }
      }
      .padding([.top, .bottom])

      // A tool for scanning and generating QR codes.
      NavigationLink {
        QRCodePickerView()
      } label: {
        HStack {
          Image(systemName: "qrcode")
            .foregroundStyle(.tint)
            .padding()
            .font(.title2)

          VStack(alignment: .leading, spacing: 8) {
            Text("QR Code Tool")
              .font(.headline)

            Text("Scans and generates QR codes.")
              .font(.caption)
          }
          .padding(.trailing)
        }
      }
      .padding([.top, .bottom])
    }
    .listStyle(.plain)
    .navigationTitle(Text("Toolbox"))
  }
}

struct ToolsView: View {
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .pad {
      NavigationSplitView {
        ToolsInnerView()
      } detail: {
        Text("Select a tool to start.")
          .foregroundStyle(.secondary)
      }
    } else {
      NavigationStack {
        ToolsInnerView()
      }
    }
  }
}

#Preview {
  ToolsView()
    .modelContainer(SampleData.shared.container)
}
