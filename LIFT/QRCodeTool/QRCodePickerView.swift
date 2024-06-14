//
//  QRCodePickerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct QRCodePickerView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          QRCodeGeneratorView()
        } label: {
          HStack {
            Image(systemName: "paperplane.circle")
              .foregroundColor(Color.accentColor)
              .padding()
              .font(.title2)

            VStack(alignment: .leading, spacing: 8) {
              Text("Generator")
                .font(.headline)
              Text("Generate a QR code from the input text.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }
        .padding([.top, .bottom])

        NavigationLink {
          QRCodeScannerView()
        } label: {
          HStack {
            Image(systemName: "qrcode.viewfinder")
              .foregroundColor(Color.accentColor)
              .padding()
              .font(.title2)

            VStack(alignment: .leading, spacing: 8) {
              Text("Scanner")
                .font(.headline)
              Text("Scan a QR code to get the content.")
                .font(.caption)
            }
            .padding(.trailing)
          }
        }
        .padding([.top, .bottom])
      }
      .listStyle(.plain)
      .navigationBarTitle(Text("QR Code Tool"), displayMode: .inline)
    }
  }
}

#Preview {
  QRCodePickerView()
}
