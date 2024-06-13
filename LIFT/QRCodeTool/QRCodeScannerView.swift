//
//  QRScannerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI
import AVFoundation

struct QRCodeScannerView: View {
  @State private var scannedCode: String = ""
  @State private var isShowingResult: Bool = false
  
  var body: some View {
    NavigationStack {
      QRCodeScannerController(scannedCode: $scannedCode, isShowingResult: $isShowingResult)
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("QR Code Scanner")
        .navigationBarTitleDisplayMode(.inline)
    }
    .navigationDestination(isPresented: $isShowingResult) {
      QRCodeResultView(scannedCode: scannedCode)
    }
  }
}

struct QRCodeScannerController: UIViewControllerRepresentable {
  @Binding var scannedCode: String
  @Binding var isShowingResult: Bool
  
  class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var parent: QRCodeScannerController
    
    init(parent: QRCodeScannerController) {
      self.parent = parent
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
      if let metadataObject = metadataObjects.first {
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        guard let stringValue = readableObject.stringValue else { return }
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        parent.scannedCode = stringValue
        parent.isShowingResult = true
      }
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> UIViewController {
    let viewController = UIViewController()
    let captureSession = AVCaptureSession()
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
    let videoInput: AVCaptureDeviceInput
    
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return viewController
    }
    
    if (captureSession.canAddInput(videoInput)) {
      captureSession.addInput(videoInput)
    } else {
      return viewController
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    
    if (captureSession.canAddOutput(metadataOutput)) {
      captureSession.addOutput(metadataOutput)
      
      metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      return viewController
    }
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = viewController.view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    viewController.view.layer.addSublayer(previewLayer)
    
    //        captureSession.startRunning()
    DispatchQueue.global(qos: .userInitiated).async {
      captureSession.startRunning()
    }
    
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
  QRCodeScannerView()
}
