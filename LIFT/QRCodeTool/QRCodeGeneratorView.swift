//
//  QRCodeGeneratorView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import EFQRCode
import SwiftUI

struct QRCodeGeneratorView: View {
  @State private var inputText: String = ""
  @State private var isSheetPresented = false
  @State private var qrCodeImage: UIImage?

  var body: some View {
    NavigationStack {
      VStack {
        TextEditor(text: $inputText)
          .frame(maxHeight: .infinity)
          .padding(20)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.tint)
              .padding()
          )
      }
      .navigationTitle("QR Code Generator")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Generate") {
            generateQRCode()
          }
        }
      }
      .sheet(isPresented: $isSheetPresented) {
        QRCodeSheetView(qrCodeImage: qrCodeImage)
      }
    }
  }

  func generateQRCode() {
    if let cgImage = EFQRCode.generate(
      for: inputText,
      backgroundColor: UIColor.white.cgColor,
      foregroundColor: UIColor.black.cgColor
    ) {
      self.qrCodeImage = UIImage(cgImage: cgImage)
    } else {
      self.qrCodeImage = UIImage(systemName: "xmark.circle.fill")
    }

    self.isSheetPresented = true
  }
}

#Preview {
  QRCodeGeneratorView()
}
