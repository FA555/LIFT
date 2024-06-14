//
//  QRScannerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import AVFoundation
import SwiftUI

// View for QR code scanning
struct QRCodeScannerView: View {
  // State variable to store the scanned QR code string
  @State private var scannedCode: String = ""
  // State variable to control the presentation of the result view
  @State private var isShowingResult: Bool = false

  var body: some View {
    // Navigation stack for navigation-based UI
    NavigationStack {
      // Custom controller for QR code scanning
      QRCodeScannerController(
        scannedCode: $scannedCode, isShowingResult: $isShowingResult
      )
      .edgesIgnoringSafeArea(.all)  // Extend the view to edges
      .navigationTitle("QR Code Scanner")  // Set the navigation title
      .navigationBarTitleDisplayMode(.inline)  // Display title inline
    }
    // Navigation destination to show the result view when a QR code is scanned
    .navigationDestination(isPresented: $isShowingResult) {
      QRCodeResultView(scannedCode: scannedCode)  // Pass scanned code to result view
    }
  }
}

// Controller to handle QR code scanning using UIViewControllerRepresentable
struct QRCodeScannerController: UIViewControllerRepresentable {
  // Binding variables to pass data between SwiftUI and UIKit
  @Binding var scannedCode: String
  @Binding var isShowingResult: Bool

  // Coordinator class to handle delegate methods for QR code scanning
  class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var parent: QRCodeScannerController

    init(parent: QRCodeScannerController) {
      self.parent = parent
    }

    // Delegate method called when a metadata object is detected
    func metadataOutput(
      _ output: AVCaptureMetadataOutput,
      didOutput metadataObjects: [AVMetadataObject],
      from connection: AVCaptureConnection
    ) {
      if let metadataObject = metadataObjects.first {
        guard
          let readableObject = metadataObject
            as? AVMetadataMachineReadableCodeObject
        else { return }
        guard let stringValue = readableObject.stringValue else { return }
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))  // Vibrate on successful scan
        parent.scannedCode = stringValue  // Update scanned code
        parent.isShowingResult = true  // Show result view
      }
    }
  }

  // Create the coordinator instance
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }

  // Method to create the UIViewController
  func makeUIViewController(context: Context) -> UIViewController {
    let viewController = UIViewController()
    let captureSession = AVCaptureSession()
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
      return viewController
    }
    let videoInput: AVCaptureDeviceInput

    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return viewController
    }

    // Add the video input to the capture session
    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      return viewController
    }

    let metadataOutput = AVCaptureMetadataOutput()

    // Add the metadata output to the capture session
    if captureSession.canAddOutput(metadataOutput) {
      captureSession.addOutput(metadataOutput)

      metadataOutput.setMetadataObjectsDelegate(
        context.coordinator, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]  // Set metadata type to QR
    } else {
      return viewController
    }

    // Create and configure the preview layer
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = viewController.view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    viewController.view.layer.addSublayer(previewLayer)

    // Start the capture session on a background thread
    DispatchQueue.global(qos: .userInitiated).async {
      captureSession.startRunning()
    }

    return viewController
  }

  // Method to update the UIViewController (not used in this case)
  func updateUIViewController(
    _ uiViewController: UIViewController, context: Context
  ) {}
}

// Preview provider for SwiftUI previews
#Preview {
  QRCodeScannerView()
}
