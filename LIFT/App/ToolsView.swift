//
//  ToolsView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct ToolsView: View {
  var body: some View {
    NavigationSplitView {
      List {
        NavigationLink {
          ModePickerView()
        } label: {
          HStack {
            Image(systemName: "metronome")
              .foregroundStyle(.tint)
              .padding()
              .font(.title2)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("Seismometer")
                .font(.headline)
              
              Text("A tool that measures the device’s vibrations.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }
        .padding([.top, .bottom])
        
        NavigationLink {
          Text("1919810")
        } label: {
          HStack {
            Image(systemName: "calendar")
              .foregroundStyle(.tint)
              .padding()
              .font(.title2)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("DDL Planner")
                .font(.headline)
              
              Text("A tool that helps you plan your DDLs.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }
        .padding([.top, .bottom])

        NavigationLink {
          Text("810893")
        } label: {
          HStack {
            Image(systemName: "gift")
              .foregroundStyle(.tint)
              .padding()
              .font(.title2)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("Birthday Reminder")
                .font(.headline)
              
              Text("A tool that organises all your friends' birthdays.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }
        .padding([.top, .bottom])

        // A tool for scanning and generating QR codes.
        NavigationLink {
          Text("810893")
        } label: {
          HStack {
            Image(systemName: "qrcode")
              .foregroundStyle(.tint)
              .padding()
              .font(.title2)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("QR Code Tool")
                .font(.headline)
              
              Text("A tool for scanning and generating QR codes.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }
        .padding([.top, .bottom])
      }
      .listStyle(.plain)
      .navigationTitle(Text("Toolbox"))
    } detail: {
      Text("Select a tool.")
        .foregroundStyle(.secondary)
    }
  }
}

#Preview {
  ToolsView()
}
