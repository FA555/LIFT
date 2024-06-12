//
//  GaugeBackgroundView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI

extension Angle: Identifiable {
  public var id: Double {
    radians
  }
}

struct GaugeBackgroundView: View {
  let width: Double
  let minAngle = Angle(degrees: -90)
  let maxAngle = Angle(degrees: 90)
  let tickCount = 17

  var tickLength: Double {
    width * 0.04
  }

  var gaugeTickAngles: [Angle] {
    let tickDegrees = (maxAngle.degrees - minAngle.degrees) / (Double(tickCount) - 1)
    var angles = [Angle]()

    for tick in 1..<tickCount - 1 {
      angles.append(Angle(degrees: 90 - (Double(tick) * tickDegrees)))
    }

    return angles
  }

  var body: some View {
    ZStack {
      Path { path in
        path.addArc(
          center: CGPoint(x: width / 2, y: width / 2),
          radius: width / 2,
          startAngle: Angle(degrees: minAngle.degrees + 90),
          endAngle: Angle(degrees: maxAngle.degrees + 90),
          clockwise: true
        )
      }
      .fill()
//      .foregroundColor(Color.accentColor.opacity(0.1))
      .foregroundStyle(.thinMaterial)

      ForEach(gaugeTickAngles) { angle in
        Rectangle()
          .frame(width: 1, height: tickLength)
          .offset(y: -width / 2 + tickLength)
          .rotationEffect(angle, anchor: UnitPoint(x: 0.5, y: 1))
          .offset(y: width / 4 - tickLength / 2)
      }
    }
    .frame(width: width, height: width / 2)
  }
}

#Preview {
  GaugeBackgroundView(width: 300)
}
