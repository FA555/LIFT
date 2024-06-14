//
//  QRCodeResultView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct QRCodeResultView: View {
  var scannedCode: String
  @State private var showAlert = false

  var body: some View {
    NavigationStack {
      GeometryReader { geometry in
        Text(scannedCode)
          .frame(
            minWidth: geometry.size.width - 40,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .padding(20)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.tint)
              .padding()
          )
          .navigationTitle("Scan Result")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            ToolbarItem(placement: .confirmationAction) {
              Button("Copy") {
                UIPasteboard.general.string = scannedCode
                showAlert = true
              }
              .alert("Copied", isPresented: $showAlert) {
                Button("OK") {
                  showAlert = false
                }
              }
            }
          }
      }
    }
  }
}

#Preview {
  QRCodeResultView(scannedCode: "Sample QR Code Content")
}
