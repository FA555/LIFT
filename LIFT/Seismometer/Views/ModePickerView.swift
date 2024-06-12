//
//  ModePickerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct ModePickerView: View {
  @EnvironmentObject private var detector: MotionDetector
  
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          NeedleSeismometerView()
        } label: {
          HStack() {
            Image(systemName: "gauge")
              .foregroundColor(Color.accentColor)
              .padding()
              .font(.title2)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("Needle")
                .font(.headline)
              Text("A needle that responds to the device’s vibration.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }.padding([.top, .bottom])
        
        NavigationLink {
          GraphSeismometerView()
        } label: {
          HStack() {
            Image(systemName: "waveform")
              .foregroundColor(Color.accentColor)
              .padding()
              .font(.title2)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("Graph")
                .font(.headline)
              Text("A graph that shows the device’s vibration.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }.padding([.top, .bottom])
      }
      .listStyle(.plain)
      .navigationBarTitle(Text("Seismometer"), displayMode: .inline)
    }
  }
}

#Preview {
  ModePickerView()
    .environmentObject(MotionDetector(updateInterval: 0.05))
}
