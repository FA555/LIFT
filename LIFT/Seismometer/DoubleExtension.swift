//
//  DoubleExtension.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import Foundation

// Extension to add functionality to Double type
extension Double {

  // Method to format a Double as a fixed length string
  // with specified integer and fraction digits
  func describeAsFixedLengthString(
    integerDigits: Int = 2, fractionDigits: Int = 2
  ) -> String {
    // Use the formatted method to create a string representation
    // with the desired format
    self.formatted(
      .number
        .sign(strategy: .always())  // Always show the sign (+/-)
        .precision(
          .integerAndFractionLength(
            integer: integerDigits,  // Number of integer digits
            fraction: fractionDigits  // Number of fraction digits
          )
        )
    )
  }
}
