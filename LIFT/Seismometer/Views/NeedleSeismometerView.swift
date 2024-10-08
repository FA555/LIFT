//
//  NeedleSeismometerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

struct NeedleSeismometerView: View {
  @ObservedObject private var detector = MotionDetector(updateInterval: 0.05)

  let needleAnchor = UnitPoint(x: 0.5, y: 1)
  let amplification = 2.0
  var rotationAngle: Angle {
    Angle(radians: -detector.zAcceleration * amplification)
  }

  var body: some View {
    VStack {
      Spacer()

      ZStack(alignment: .bottom) {
        GaugeBackgroundView(width: 250)

        Rectangle()
          .foregroundColor(Color.accentColor)
          .frame(width: 5, height: 150)
          .rotationEffect(rotationAngle, anchor: needleAnchor)
          .overlay {
            VStack {
              Spacer()

              Circle()
                .stroke(lineWidth: 3)
                .fill()
                .frame(width: 10, height: 10)
                .foregroundStyle(.tint)
                .background(.white)
                .offset(x: 0, y: 5)
            }
          }
      }

      Spacer()
        .frame(height: 50)

      Text("\(detector.zAcceleration.describeAsFixedLengthString())")
        .font(.system(.body, design: .monospaced))
        .fontWeight(.semibold)

      Spacer()

      Text("Set the device on a flat surface to record vibrations.")
        .font(.caption)
        .foregroundStyle(.secondary)
        .padding()
    }
    .onAppear {
      detector.start()
    }
    .onDisappear {
      detector.stop()
    }
  }
}

#Preview {
  NeedleSeismometerView()
}
