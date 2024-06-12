//
//  DoubleExtension.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import Foundation

extension Double {
  func describeAsFixedLengthString(integerDigits: Int = 2, fractionDigits: Int = 2) -> String {
    self.formatted(
      .number
        .sign(strategy: .always())
        .precision(
          .integerAndFractionLength(
            integer: integerDigits,
            fraction: fractionDigits
          )
        )
    )
  }
}
