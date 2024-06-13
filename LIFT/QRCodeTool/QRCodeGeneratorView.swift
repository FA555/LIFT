//
//  QRCodeGeneratorView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI
import EFQRCode

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
        
        Spacer()
      }
      .navigationTitle("QR Code Generator")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Generate") {
            generateQRCode()
          }
        }
      }
      .sheet(isPresented: $isSheetPresented) {
//        QRCodeSheetView(qrCodeImage: qrCodeImage)
        Text(inputText)
      }
    }
  }
  
  func generateQRCode() {
    if let cgImage = EFQRCode.generate(
      for: inputText,
      backgroundColor: UIColor.white.cgColor,
      foregroundColor: UIColor.black.cgColor
    ) {
      qrCodeImage = UIImage(cgImage: cgImage)
      isSheetPresented = true
    } else {
      qrCodeImage = nil
      isSheetPresented = false
    }
  }
}


#Preview {
  QRCodeGeneratorView()
}
