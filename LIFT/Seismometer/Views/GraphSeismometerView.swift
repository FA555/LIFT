//
//  GraphSeismometerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct GraphSeismometerView: View {
  private var detector = MotionDetector(updateInterval: 0.025)
  @State private var data = [Double]()
  let maxData = 1000

  @State private var sensitivity = 0.0
  let graphMaxValueMostSensitive = 0.01
  let graphMaxValueLeastSensitive = 1.0

  var graphMaxValue: Double {
    graphMaxValueMostSensitive + (1 - sensitivity)
      * (graphMaxValueLeastSensitive - graphMaxValueMostSensitive)
  }

  var graphMinValue: Double {
    -graphMaxValue
  }

  var body: some View {
    VStack {
      Spacer()

      LineGraph(data: data, maxData: maxData, minValue: graphMinValue, maxValue: graphMaxValue)
        .background(.thinMaterial)
        .cornerRadius(15)
        .padding()
        .aspectRatio(1, contentMode: .fit)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.black.opacity(0.25))
            .padding()
        )

      Spacer()
        .frame(height: 25)

      Text("Sensitivity")
        .font(.headline)

      Slider(
        value: $sensitivity, in: 0...0.75,
        minimumValueLabel: Text("Min"),
        maximumValueLabel: Text("Max")
      ) {
        Text("Sensitivity")
      }
      .padding([.leading, .trailing])

      Spacer()

      Text("Set the device on a flat surface to record vibrations.")
        .padding()
        .foregroundStyle(.secondary)
    }
    .onAppear {
      detector.start()
      
      detector.onUpdate = {
        data.append(-detector.zAcceleration)
        if data.count > maxData {
          data = Array(data.dropFirst())
        }
      }
    }
    .onDisappear {
      detector.stop()
    }
  }
}

#Preview {
  GraphSeismometerView()
}
