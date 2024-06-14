//
//  QRCodeSheetView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct QRCodeSheetView: View {
  @State var qrCodeImage: UIImage?
  @State private var showAlert = false
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()

        if let qrCodeImage = qrCodeImage {
          Image(uiImage: qrCodeImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
        } else {
          Text("No QR Code Generated")
            .padding()
        }

        Spacer()

        Text(
          "If no QR code is shown, please check if the input text is too long and try again."
        )
        .font(.caption)
        .foregroundStyle(.secondary)
      }
      .navigationBarTitle("QR Code", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            dismiss()
          }
        }

        ToolbarItem(placement: .confirmationAction) {
          Button("Save") {
            saveQRCode()
          }
          .alert("Saved", isPresented: $showAlert) {
            Button("OK") {
              dismiss()
            }
          }
        }
      }
      .padding()
    }
  }

  func saveQRCode() {
    guard let qrCodeImage = qrCodeImage else { return }
    UIImageWriteToSavedPhotosAlbum(qrCodeImage, nil, nil, nil)
    showAlert = true
//    DispatchQueue.main.asyncAfter(deadline: .now()) {
//      dismiss()
//    }
  }
}

#Preview {
  QRCodeSheetView(qrCodeImage: nil)
}
